/* See LICENSE file for copyright and license details. */
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <sys/stat.h>

#include "arg.h"
#include "slstatus.h"
#include "util.h"

struct arg {
	const char *(*func)(const char *);
	const char *fmt;
	const char *args;
};

char buf[1024];
static volatile sig_atomic_t done;
static Display *dpy;

#include "config.h"

/* --- Default modules --- */
static struct arg modules[3];
static size_t modules_len = 0;
static unsigned int update_interval;

/* --- Helpers to detect battery and mixer --- */
static int file_exists(const char *path) {
	struct stat st;
	return stat(path, &st) == 0;
}

/* --- Signal handler --- */
static void terminate(const int signo) {
	if (signo != SIGUSR1)
		done = 1;
}

static void difftimespec(struct timespec *res, struct timespec *a, struct timespec *b) {
	res->tv_sec = a->tv_sec - b->tv_sec - (a->tv_nsec < b->tv_nsec);
	res->tv_nsec = a->tv_nsec - b->tv_nsec + (a->tv_nsec < b->tv_nsec) * 1E9;
}

static void usage(void) {
	die("usage: %s [-v] [-s] [-1]", argv0);
}

int main(int argc, char *argv[]) {
	struct sigaction act;
	struct timespec start, current, diff, intspec, wait;
	size_t i, len;
	int sflag, ret;
	char status[MAXLEN];
	const char *res;

	sflag = 0;
	ARGBEGIN {
	case 'v':
		die("slstatus-"VERSION);
	case '1':
		done = 1;
		/* FALLTHROUGH */
	case 's':
		sflag = 1;
		break;
	default:
		usage();
	} ARGEND

	if (argc)
		usage();

	/* --- Detect available modules --- */
	modules_len = 0;
	update_interval = interval; // default from config.h

	// Check for battery
	if (file_exists("/sys/class/power_supply/BAT0/capacity")) {
		modules[modules_len++] = (struct arg){ battery_perc, "Bat_%s%%  ", "BAT0" };
		update_interval = 2000; // slower update for battery
	}

	// Check for ALSA mixer (desktop/office)
	if (file_exists("/dev/mixer")) {
		modules[modules_len++] = (struct arg){ vol_perc, "Vol_%s%%  ", "/dev/mixer" };
		update_interval = 1000; // faster update for volume
	}

	// Always add datetime
	modules[modules_len++] = (struct arg){ datetime, "%s", "%a_%b_%d  %I:%M%P " };

	/* --- Setup signal handlers --- */
	memset(&act, 0, sizeof(act));
	act.sa_handler = terminate;
	sigaction(SIGINT,  &act, NULL);
	sigaction(SIGTERM, &act, NULL);
	act.sa_flags |= SA_RESTART;
	sigaction(SIGUSR1, &act, NULL);

	/* --- Open X display if needed --- */
	if (!sflag && !(dpy = XOpenDisplay(NULL)))
		die("XOpenDisplay: Failed to open display");

	do {
		if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
			die("clock_gettime:");

		status[0] = '\0';
		for (i = len = 0; i < modules_len; i++) {
			res = modules[i].func(modules[i].args);
			if (!res)
				res = unknown_str;

			if ((ret = esnprintf(status + len, sizeof(status) - len,
			                     modules[i].fmt, res)) < 0)
				break;

			len += ret;
		}

		if (sflag) {
			puts(status);
			fflush(stdout);
			if (ferror(stdout))
				die("puts:");
		} else {
			if (XStoreName(dpy, DefaultRootWindow(dpy), status) < 0)
				die("XStoreName: Allocation failed");
			XFlush(dpy);
		}

		if (!done) {
			if (clock_gettime(CLOCK_MONOTONIC, &current) < 0)
				die("clock_gettime:");
			difftimespec(&diff, &current, &start);

			intspec.tv_sec = update_interval / 1000;
			intspec.tv_nsec = (update_interval % 1000) * 1E6;
			difftimespec(&wait, &intspec, &diff);

			if (wait.tv_sec >= 0 &&
			    nanosleep(&wait, NULL) < 0 &&
			    errno != EINTR)
				die("nanosleep:");
		}
	} while (!done);

	if (!sflag) {
		XStoreName(dpy, DefaultRootWindow(dpy), NULL);
		if (XCloseDisplay(dpy) < 0)
			die("XCloseDisplay: Failed to close display");
	}

	return 0;
}
