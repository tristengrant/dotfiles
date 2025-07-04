// Force Firefox dark mode
user_pref("layout.css.prefers-color-scheme.content-override", 2);

// Load bookmarks in background tabs
user_pref("browser.tabs.loadBookmarksInBackground", true);

// Disable telemetry and data reporting
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "");
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);

// Disable Pocket (if you don’t use it)
user_pref("extensions.pocket.enabled", false);

// Disable Firefox account sign-in UI (Sync)
user_pref("identity.fxaccounts.enabled", false);

// Enable tracking protection
user_pref("privacy.trackingprotection.enabled", true);

// Enable HTTPS-Only mode
user_pref("dom.security.https_only_mode", true);

// Block autoplay media
user_pref("media.autoplay.default", 1);

// Increase content process count
user_pref("dom.ipc.processCount", 8);

// Enable smooth scrolling
user_pref("general.smoothScroll", true);

// Enable fast back/forward cache
user_pref("browser.sessionhistory.max_total_viewers", 4);

// Enable Ctrl+Tab to cycle through tabs in recently used order
user_pref("browser.ctrlTab.recentlyUsedOrder", true);

// Disable “What’s New” page after updates
user_pref("browser.startup.homepage_override.mstone", "ignore");

// Show full URLs in address bar
user_pref("browser.urlbar.trimURLs", false);

// Enable DNS over HTTPS
user_pref("network.trr.mode", 2);
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");

// Disable WebRTC to prevent IP leaks
user_pref("media.peerconnection.enabled", false);

// Enable auto-scroll (middle-click scrolling)
user_pref("general.autoScroll", true);

// Prevent Firefox from creating a desktop icon on Linux
user_pref("browser.shell.checkDefaultBrowser", false);

// Disable sponsored suggestions in address bar
user_pref("browser.urlbar.sponsoredTopSites", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);

// Disable Recommended Extensions section
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr", false);
user_pref("browser.newtabpage.activity-stream.feeds.recommendationprovider", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

// Disable "Personalize Your Firefox" and onboarding
user_pref("browser.discovery.enabled", false);
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.aboutwelcome.screens", "[]");

// Optional: clean up the new tab UI (disable snippets, sponsored, pocket, top sites)
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.showTopSites", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);

// Make new tab page completely blank
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.url", "about:blank"); // legacy fallback
user_pref("browser.newtabpage.activity-stream.enabled", false);

// Disable all Activity Stream feeds/content
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showTopSites", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
