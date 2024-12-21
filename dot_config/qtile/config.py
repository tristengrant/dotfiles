import os
import subprocess

from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call(home)

mod = "mod4" # Super/Windows key
terminal = "kitty" # Replace with your terminal
rofi_command = "rofi -show drun" # Command to launch rofi
browser = "firefox" # Your browser
krita = "./Applications/krita-5.2.6-x86_64_b91deea105204592bed527d811426f67.appimage" # Krita app
emoji = "rofi -show emoji -emoji-mode copy -emoji-display-name 'Emoji Picker:'"
calc = "rofi -show calc -no-show-match -no-sort -calc-display-name 'Calculation:'"
picker = "/home/tristen/Scripts/colour-picker"

keys = [
    # Switch between groups
    Key([mod, "control"], "Left", lazy.screen.prev_group(), desc="Move to previous group"),
    Key([mod, "control"], "Right", lazy.screen.next_group(), desc="Move to next group"),

    # Move windows across displays
    Key([mod, "shift"], "Right", lazy.window.toscreen(0), desc="Move window to screen 1"),
    Key([mod, "shift"], "Left", lazy.window.toscreen(1), desc="Move window to screen 0"),

    #Move windows around within a group/workspace
    Key([mod, "mod1"], "Left", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "mod1"], "Right", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([mod, "mod1"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "mod1"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),

    # Move windows within layout
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),

    # Close window
    Key([mod], "q", lazy.window.kill(), desc="Close the focused window"),

    # Reload config
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),

    # Quit Qtile
    Key([mod, "control"], "q", lazy.shutdown(), desc="Quit Qtile"),

    # Launch Rofi
    Key([mod], "r", lazy.spawn(rofi_command), desc="Launch Rofi"),

    # Open kitty terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Open Kitty terminal"),

    # Open Firefox
    Key([mod], "w", lazy.spawn(browser), desc="Open Firefox"),

    # Open Krita
    Key([mod], "k", lazy.spawn(krita), desc="Open Krita"),

    # Launch Rofi Emoji picker
    Key([mod], "e", lazy.spawn(emoji), desc="Launch Rofi emoji picker"),

    # Launch Rofi calculator
    Key([mod], "c", lazy.spawn(calc), desc="Launch Rofi calculator"),

    # Screenshot keybindings
    Key([], "Print", lazy.spawn("/home/tristen/Scripts/screenshot select"), desc="Screenshot of selection"),
    Key(["shift"], "Print", lazy.spawn("/home/tristen/Scripts/screenshot"), desc="Screenshot of all displays"),
    Key(["mod1"], "Print", lazy.spawn("/home/tristen/Scripts/screenshot window"), desc="Screenshot of window"),

    # Colorpicker
    Key([mod], "p", lazy.spawn(picker), desc="Pick a colour to see its hex value"),

    # Music player controlls
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop"), desc="Stop music player"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause player"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Play previous track"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Play next track"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

# Bind groups to specific display
groups = [
    # Screen affinity here is used to make
    # sure the groups startup on the right screens
    Group(name="1", screen_affinity=0, label="1", layout="monadtall"),
    Group(name="2", screen_affinity=0, label="2", layout="monadtall"),
    Group(name="3", screen_affinity=0, label="3", layout="monadtall"),
    Group(name="4", screen_affinity=0, label="4", layout="monadtall"),
    Group(name="5", screen_affinity=0, label="5", layout="monadtall"),
    Group(name="6", screen_affinity=1, label="6", layout="verticaltile"),
    Group(name="7", screen_affinity=1, label="7", layout="verticaltile"),
    Group(name="8", screen_affinity=1, label="8", layout="verticaltile"),
    Group(name="9", screen_affinity=1, label="9", layout="verticaltile"),
    Group(name="0", screen_affinity=1, label="10", layout="verticaltile"),
]

def go_to_group(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.groups_map[name].toscreen()
            return

        if name in '12345':
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        else:
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner

for i in groups:
    keys.append(Key([mod], i.name, lazy.function(go_to_group(i.name))))

def go_to_group_and_move_window(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.current_window.togroup(name, switch_group=False)
            return

        if name in "12345":
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        else:
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner

for i in groups:
    keys.append(Key([mod, "shift"], i.name, lazy.function(go_to_group_and_move_window(i.name))))

# Define scratchpads
groups.append(ScratchPad("scratchpad", [
    DropDown("term", "kitty --class=scratch", width=0.8, height=0.8, x=0.1, y=0.1, on_focus_lost_hide=True, warp_pointer=True, opacity=1.0),
    DropDown("music", "kitty --class=scratch musikcube", width=0.8, height=0.8, x=0.1, y=0.1, on_focus_lost_hide=True, warp_pointer=True, opacity=1.0),
    DropDown("files", "kitty --class=scratch yazi", width=0.8, height=0.8, x=0.1, y=0.1, on_focus_lost_hide=True, warp_pointer=True, opacity=1.0),
]))

# Scratchpad keybindings
keys.extend([
    Key([mod, "shift"], "Return", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod], "m", lazy.group['scratchpad'].dropdown_toggle('music')),
    Key([mod], "f", lazy.group['scratchpad'].dropdown_toggle('files')),
])

layout_defaults = dict(
    border_focus="#a3a3a3",
    border_normal="#333333",
    border_width=1,
    single_border_width=0,  # Remove border when there's only one window
    single_margin=0         # Optional: Remove margin for single window
)

layout_defaults = layout_defaults.copy()

layouts = [
    # layout.Columns(
    #     border_focus="#a3a3a3",
    #     border_normal="#333333",
    #     # border_normal="#000000",
    #     border_width=1,
    #     insert_position=1,
    #     margin=0,
    #     margin_on_single=0,
    # ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(**layout_defaults),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    layout.VerticalTile(**layout_defaults),
    layout.Max(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="JetBrains Mono Nerd Font",
    fontsize=16,
    padding=3,
    background="#000000",
    foreground="#888888"
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [   # Main Display
                widget.GroupBox(
                    visible_groups=["1", "2", "3", "4", "5"],
                    active="#FFFFFF",
                    block_highlight_text_color="#FFFFFF",
                    this_screen_border="000000",
                    this_current_screen_border="#224488",
                    other_screen_border="#000000",
                    other_current_screen_border="#224488",
                    highlight_method="block",
                    borderwidth=10,
                    margin_x=0,
                    padding_y=6,
                    disable_drag=True,
                    rounded=False,
                    inactive="#888888",
                    fontsize=16,
                    toggle=False,
                    use_mouse_wheel=False,
                    urgent_alert_method="Block",
                    urgent_text="#cc9a1c",
                    border="#000000",
                ),
                widget.Prompt(),
                widget.WindowName(
                    background="#224488",
                    foreground="#FFFFFF",
                    padding=10,
                ),
                widget.Sep(
                    background="#224488",
                    foreground="#224488",
                    linewidth=0,
                    padding=10,
                ),
                widget.Mpris2(
                    padding=10,
                    format="{xesam:title} - {xesam:artist}",
                    width=400,
                    scroll=True,
                ),
                widget.DF(
                    fmt="{}",
                    format="{uf}{m}|{r:.0f}%",
                    measure="G",
                    partition="/",
                    visible_on_warn=False,
                    padding=10,
                ),
                widget.Memory(
                    fmt="{}",
                    format="{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
                    measure_mem="G",
                    padding=10,
                ),
                widget.CPU(
                    fmt="{}",
                    format="{load_percent}%",
                    padding=10,
                ),
                widget.OpenWeather(
                    api_key="19d20f7da04bedf930d8b8a546704de9",
                    location="Winnipeg",
                    fmt="{}",
                    format="{main_temp:.0f}°{units_temperature}",
                    padding=10,
                ),
                widget.Clock(
                    format="%a %b %d %I:%M %p",
                    padding=10,
                ),
                widget.QuickExit(
                    default_text="[X]",
                    countdown_format="[{}]",
                    padding=5,
                ),
            ],
            30,
            background="#000000",
        ),
    ),
    Screen(
        top=bar.Bar(
            [   # Portait Display
                widget.GroupBox(
                    visible_groups=["6", "7", "8", "9", "0"],
                    active="#FFFFFF",
                    block_highlight_text_color="#FFFFFF",
                    this_screen_border="000000",
                    this_current_screen_border="#224488",
                    other_screen_border="#000000",
                    other_current_screen_border="#224488",
                    highlight_method="block",
                    borderwidth=10,
                    margin_x=0,
                    padding_y=6,
                    disable_drag=True,
                    rounded=False,
                    inactive="#888888",
                    fontsize=16,
                    toggle=False,
                    use_mouse_wheel=False,
                    urgent_alert_method="Block",
                    urgent_text="#cc9a1c",
                    border="#000000",
                ),
                widget.Prompt(),
                widget.WindowName(
                    background="#224488",
                    foreground="#FFFFFF",
                    padding=10,
                ),
                widget.Sep(
                    background="#224488",
                    foreground="#224488",
                    linewidth=0,
                    padding=10,
                ),
                widget.Systray(
                    padding=10,
                ),
                widget.Clock(
                    format="%a %b %d %I:%M %p",
                    padding=10,
                ),
            ],
            30,
            background="#000000",
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus="#a3a3a3",
    border_normal="#333333",
    border_width=1,
    margin=0,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="FX: Track 1"),
        Match(title="FX: Track 1 [BYPASSED]"),
        Match(title="FX: Track 2"),
        Match(title="FX: Track 2 [BYPASSED]"),
        Match(title="FX: Track 3"),
        Match(title="FX: Track 3 [BYPASSED]"),
        Match(title="FX: Track 4"),
        Match(title="FX: Track 4 [BYPASSED]"),
        Match(title="FX: Track 5"),
        Match(title="FX: Track 5 [BYPASSED]"),
        Match(title="FX: Track 6"),
        Match(title="FX: Track 6 [BYPASSED]"),
        Match(title="FX: Track 7"),
        Match(title="FX: Track 7 [BYPASSED]"),
        Match(title="FX: Track 8"),
        Match(title="FX: Track 8 [BYPASSED]"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 16

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
