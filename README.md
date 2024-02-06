# KLinux
## Table of Content
- [Introduction](#1-introduction)
    - [Overview](#11-overview)
    - [Target Audience](#12-target-audience)
    - [Key Features](#13-key-features)
- [Installation](#2-installation)
    - [System Requirements](#21-system-requirements)
    - [Troubleshooting](#22-troubleshooting)
- [Configuration](#3-configuration)
    - [Qtile Configuration](#31-qtile-configuration)
- [User Guide](#4-user-guide)
    - [Qtile Window Manager](#41-qtile-window-manager)
        - [Navigation](#411-navigation)
    - [Software Management](#42-software-management)
- [Advanced Topics](#5-advanced-topics)
    - [Networking](#51-networking)
    - [Troublesooting](#52-troubleshooting)
- [Support and Community](#6-support-and-community)
    - [Documentation](#61-documentation)
    - [Community support](#62-community-support)
- [Conclution](#7-conclusion)
    - [Contact](#71-contact-information)
- [Appendices](#8-appendices)
    - [Additional resources](#81-additional-resources)

## 1. Introduction
KLinux is a streamlined installation script designed for Arch-based Linux distributions, aiming to simplify the setup process for users who want to seamlessly adopt a customized computing environment. This script automates the installation of key components, ensuring a hassle-free deployment of your preferred configuration.
## Screenshot
![Screenshot](2023-09-26_18-21.png)

### 1.1 Overview
- KLinux is designed to cater to users who are new to the Arch Linux ecosystem. If you're taking your first steps into the Arch world, this script serves as a helpful companion, guiding you through the installation of essential components with ease.

#### 1.2 Target Audience
- The KLinux installation script stands out from others due to its focus on simplicity and its unique appeal to two specific user groups:
    ##### 1.2.1 New Arch Linux Users

    - Description: KLinux recognizes the challenges that newcomers to Arch Linux may face during the initial setup. Unlike other installation scripts, KLinux provides a seamless onboarding experience for users taking their first steps into the Arch Linux ecosystem.
    - Differentiators: 
        - Automation for Newcomers: KLinux automates the Arch Linux post-installation process, reducing the learning curve and potential errors for users unfamiliar with Arch's manual setup.

    ##### 1.2.2 Tiling Window Manager Novices

    - Description: KLinux sets itself apart by catering to users exploring tiling window managers (TWMs) for the first time. It offers an easy entry point into the world of tiling, particularly with the Qtile window manager.
    - Differentiators:
        - Pre-configured Qtile Environment: KLinux installs and configures Qtile, providing users with a ready-to-use tiling window manager setup without the need for extensive customization.
    - Guided Neovim Configuration: The script includes a pre-configured Neovim setup, enhancing the experience for users new to powerful text editors like Neovim.

#### 1.3 Key Features
- This script installs following pre-configured packages,
    * Qtile Config: KLinux installs a pre-configured Qtile environment tailored to enhance your desktop experience. The configuration is optimized for efficiency and aesthetics, providing a clean and intuitive tiling window manager setup.
    * Neovim Configuration: KLinux includes a customized Neovim configuration, empowering users with a feature-rich and productive text editing experience. The setup is geared towards developers and enthusiasts who demand a powerful yet flexible editing environment.
    * Essential Applications: The script installs a curated selection of essential applications, streamlining your workflow and providing a foundation for a productive computing environment.
- Explain what sets the OS apart from others.

## 2. Installation
- You can install my configuration on Arch-based systems using `install.sh`script.
- This script first installs the required packages using the Pacman package manager and then proceeds to clone the [Qtile config](https://github.com/kaveen-lakmuthu/qtile) repository.
- Then execute the script,
  ```
    chmod +x install.sh
    ```
- Then you can run it using,
  ```
    ./install.sh
    ```
- Make sure to run the script with elevated privileges using `sudo` as some of the packages and the service activation require administrative permissions.
- And then start the `xsession`.

### 2.1 System Requirements
- Check minimum requirements for arch linux on [Arch Wiki](https://wiki.archlinux.org/)
- Prerequisite,
    ```
    Basic Arch Linux install
    Xserver
    NetworkManager
    ```

### 2.2 Troubleshooting
- If lightdm service won't start,
    - Install `lightdm-gtk-greeter` and re enable `lightdm.service`.
    - For more troubleshooting guides, check [Lightdm](https://wiki.archlinux.org/title/Lightdm) page on Arc Linux. 

## 3. Configuration

### 3.1 Qtile configuration
- Qtile configuration files are saved on `~/.config/qtile/` directory.
- Open `config.py` to access qtile configuration.
    ```
    # KLinux Qtile Config File
    #
    # _   __ _     _                  
    #| | / /| |   (_)                 
    #| |/ / | |    _ _ __  _   ___  __
    #|    \ | |   | | '_ \| | | \ \/ /
    #| |\  \| |___| | | | | |_| |>  < 
    #\_| \_/\_____/_|_| |_|\__,_/_/\_\
    #
    #
    #
    from libqtile import bar, layout, widget
    from libqtile.config import Click, Drag, Group, Key, Match, Screen
    from libqtile.lazy import lazy
    from libqtile.utils import guess_terminal
    import os
    import subprocess
    from libqtile import hook
    from qtile_extras.widget.decorations import BorderDecoration, _Decoration, RectDecoration

    mod = "mod4"
    terminal = "alacritty"

    keys = [
        # A list of available commands that can be bound to keys can be found
        # at https://docs.qtile.org/en/latest/manual/config/lazy.html

        
        # Switch between windows
        Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
        Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
        Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
        Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
        Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key(
            [mod, "shift"],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
        ),
        Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
        
        # Run apps
        Key([mod], "f", lazy.spawn('firefox')),
        Key([mod], "t", lazy.spawn('thunar')),
        #Key([mod], "d", lazy.spawn('rofi -show drun')),
        Key([mod], "d", lazy.spawn('dmenu_run')),
        Key([], "Print", lazy.spawn('flameshot gui')),

        # Media
        #Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
        #Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
        #Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),

        Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
        Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
        Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
        Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
        
        # Key([], " XF86Lock", lazy.spawn("dm-tool lock")),
        Key([mod], "n", lazy.layout.normalize()),

        # RESIZE UP, DOWN, LEFT, RIGHT
        Key([mod, "control"], "l",
            lazy.layout.grow_left(),
            lazy.layout.grow(),
            lazy.layout.increase_ratio(),
            lazy.layout.delete(),
            ),
        Key([mod, "control"], "h",
            lazy.layout.grow_right(),
            lazy.layout.shrink(),
            lazy.layout.decrease_ratio(),
            lazy.layout.add(),
            ),
        Key([mod, "control"], "k",
            lazy.layout.grow_down(),
            lazy.layout.grow(),
            lazy.layout.decrease_nmaster(),
            ),
        Key([mod, "control"], "j",
            lazy.layout.grow_up(),
            lazy.layout.shrink(),
            lazy.layout.increase_nmaster(),
            ),

    ]

    groups = [Group(i) for i in "123456789"]

    for i in groups:
        keys.extend(
            [
                # mod1 + letter of group = switch to group
                Key(
                    [mod],
                    i.name,
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                ),
                # mod1 + shift + letter of group = switch to & move focused window to group
                Key(
                    [mod, "shift"],
                    i.name,
                    lazy.window.togroup(i.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(i.name),
                ),
                # Or, use below if you prefer not to switch to that group.
                # # mod1 + shift + letter of group = move focused window to group
                # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                #     desc="move focused window to group {}".format(i.name)),
            ]
        )

        layout_theme={
            "border_width": 5,
            "margin" : 10,
            "border_focus": "#9900cc",
            "border_normal": "#666699"
            }

    layouts = [
        #layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
        # Try more layouts by unleashing below layouts.
        # layout.Stack(num_stacks=2),
        # layout.Bsp(),
        # layout.Matrix(),
        layout.MonadTall(**layout_theme),
        layout.Max(),
        # layout.Floating(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
    ]

    widget_defaults = dict(
        font="sans",
        fontsize=10,
        padding=3,
        background='#666699',
    )

    decoration_group = {
        "decorations": [
            RectDecoration(colour="#004040", radius=10, filled=True, padding_y=4, group=True),
        ],
        "padding": 10,
    }

    extension_defaults = widget_defaults.copy()

    screens = [
        Screen(
            top=bar.Bar(
                [
                    widget.Sep(
                        linewidth=1,
                        padding = 10,
                        foreground = '#9900ff',
                        background= '#9900ff',),

                    widget.Image(
                        filename = "~/.config/qtile/qtilelogo.png",
                        iconsize = 9,
                        background= '#9900cc',
                        mouse_callbacks = {
                            'Button1':lambda : lazy.spawn(
                                'rofi -show drun'
                                )
                            }
                        ),

                    # widget.CurrentLayout(),

                    widget.GroupBox(
                        background='#9900cc',
                        foreground='#ffcccc',),

                    widget.Prompt(),

                    widget.WindowName(),

                    widget.Chord(
                        chords_colors={
                            "launch": ("#ff0000", "#ffffff"),
                        },
                        name_transform=lambda name: name.upper(),
                    ),

                    #widget.Backlight(
                        #background='ffffff',
                        #foreground='000000',
                        #backlight_name='amdgpu_bll',
                        #brightness_file='/sys/class/backlight/amdgpu_bll/brightness',
                # ),

                    #widget.BatteryIcon(),
                    #widget.Battery(
                        #background='#cc0000',
                        #foreground='#ffff99',
                        #notify_below='20%'
                        #),

                    #widget.Clipboard(width=10),
                    

                    # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                    # widget.StatusNotifier(),

                    widget.CurrentLayout(),

                    widget.Systray(
                        background='#66ccff',
                        ),

                    widget.Clock(format="%d-%m-%Y %a %H:%M:%S",
                                background='#9900cc',
                                foreground='#ffffff',
                                **decoration_group
                                ),

                    widget.QuickExit(
                            background='#ff0000',
                            foreground='ffffff'),
                ],
                24,
                # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
                # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
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
    cursor_warp = False
    floating_layout = layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
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

    # XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
    # string besides java UI toolkits; you can see several discussions on the
    # mailing lists, GitHub issues, and other WM documentation that suggest setting
    # this string if your java app doesn't work correctly. We may as well just lie
    # and say that we're a working one by default.
    #
    # We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
    # java that happens to be on java's whitelist.
    wmname = "LG3D"


    @hook.subscribe.startup_once
    def autostart_once():
        subprocess.run('/home/kaveen/.config/qtile/autostart_once.sh')
    ```
- `autostart_once.sh` file contains programmes that need to be autostart in login.
    ```
    #!/bin/sh
    #
    picom &
    lxsession &
    redshift-gtk -l 6:79 &
    volumeicon &
    nm-applet &
    nitrogen --restore &
    blueman-applet &
    xfce4-power-manager &
    dunst &
    /usr/bin/emacs --daemon &
    flameshot &
    light-locker &
    polkit &
    ```
- The default shell `ZSH` uses `starship` shell prompt as Default.
- You can customize it using guide on [Starship](https://starship.rs/)
- Basic `zsh` config are located on `~/.config/zsh/.zshrc`.

## 4. User Guide

### 4.1 Qtile Window Manager
- Qtile is a dynamic tiling window manager for X11 that is simple, extensible, and written in Python. Unlike traditional desktop environments, Qtile follows a tiling window management paradigm, organizing open windows in a non-overlapping layout. This design promotes efficiency and keyboard-centric control.
- Qtile dynamically adjusts the layout of windows based on user-defined rules and configurations.
- Windows are tiled side-by-side without overlapping, maximizing screen real estate.
- Configuration is done entirely in Python, providing users with a powerful and flexible way to customize their window manager.
- Users can leverage their Python knowledge to extend or modify Qtile to suit their preferences.
    #### 4.1.1 Navigation
    - Mod key is SUPER key.

    |Key |Option|
    | -----: | :----|
    |Mod + Return  | Opens Terminal (alacritty)|
    |Mod + d| Opens Dmenu|
    |Mod + f| Opens Firefox|
    |Mod + t| Opens Filemanager (Thunar)|
    |Mod + TAB| Toggle between layouts|
    |Mod + q| Kill focused window|
    |Mod + Ctrl + r| Reload the config|
    |Mod + Ctrl + q| Shutdown Qtile|
    |Mod + r| Spawn a command using a prompt widget|
    |Print| Flameshot gui|

    |Key|Option|
    |---:|:---|
    |Mod + h| Move focus to left|
    |Mod + l| Move focus to right|
    |Mod + j| Move focus to down|
    |Mod + k| Move focus to up|
    |Mod + space| Move window focus to other window|
    |Mod + Shift + h| Move window to the left|
    |Mod + Shift + l| Move window to the right|
    |Mod + Shift + j| Move window to the down|
    |Mod + Shift + k| Move window to the up|
    |Mod + Ctrl + h| Grow window to the left|
    |Mod + Ctrl + l| Grow window to the right|
    |Mod + Ctrl + j| Grow window to the down|
    |Mod + Ctrl + k| Grow window to the up|
    |Mod + Ctrl + n| Reset all window sizes
    |Mod + Shift + Return| Toggle between split and unsplit sides of stack|
    |Mod + 1| Switch workspace 1|
    |Mod + 2| Switch workspace 2|
    |...| 



### 4.2 Software Management
- Software management is done by Arch Linux package manager `Pacman`.
- See on [Arch wiki](https://wiki.archlinux.org/title/Pacman).
- System update:
    ```
    sudo pacman -Syu
    ```
- Install software:
    ```
    sudo pacman -S <package_name>
    ```
- Access AUR:
    - [AUR Arch wiki](https://wiki.archlinux.org/title/AUR_helpers)

## 5. Advanced Topics

### 5.1 Networking
- `NetworkManager` is not enabled by default.
- You must install and enable `NetworkManager.service` before running the script.
- GUFW will be installed when you run the script. Manually enable the firewall programme.

### 5.2 Troubleshooting
- [General Troubleshooting](https://wiki.archlinux.org/title/General_troubleshooting)

## 6. Support and Community

### 6.1 Documentation
- [Arch WIKI](https://wiki.archlinux.org/title/Main_page)
- [Arch Linux Forums](https://bbs.archlinux.org/)

### 6.2 Community Support
- [Arch Linux Forums](https://bbs.archlinux.org/)
- [KLinux GitHub](https://github.com/kaveen-lakmuthu/KLinux)

## 7. Conclusion

<!-- ### 7.1 Acknowledgments -->

### 7.1 Contact Information
- Email: kaveensalakmuthu@gmail.com
- Youtube: [Kaveen_Lakmuthu](https://www.youtube.com/@Kaveen_Lakmuthu)
- Linkedin: [Kaveen-Lakmuthu](https://www.linkedin.com/in/kaveen-lakmuthu)

## 8. Appendices

### 8.1 Additional Resources
- [Arch Wiki](https://wiki.archlinux.org/title/Main_page)
