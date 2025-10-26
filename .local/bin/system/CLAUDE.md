# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of system utility scripts for an Arch Linux desktop environment running DWM (Dynamic Window Manager) with dmenu. The scripts are located at `~/.local/bin/system` and handle various system automation tasks including display management, configuration backups, and desktop utilities.

## Architecture

**Script Organization Pattern**: All scripts in this directory are standalone executables designed to be invoked either:
- Via DWM keybindings (MOD+key combinations)
- Through the `script_menu` launcher (dmenu-based script selector)
- Directly from the command line
- Automatically via udev rules (e.g., hdmi-auto-enable)

**Key Integration Points**:
- `script_menu`: Two-level dmenu launcher that discovers all scripts in `~/.local/bin/*` subdirectories
- `shortcut_menu`: Reference documentation showing DWM keybindings that trigger these scripts
- `copy_configuration`: Backs up entire environment to `~/.local/src/archrice` (dotfiles, configs, scripts, fonts)

**External Dependencies**:
- `dmenu` - Interactive menu system used by most scripts
- `xrandr` - Display management (hdmi-auto-enable, change_resolution)
- `xwallpaper` - Wallpaper setting (wallpaper_menu, random_wallpaper)
- `xdotool` - Keyboard simulation (search_directory)
- `pandoc` with `xelatex` - Document conversion (md_to_pdf)
- `ffmpeg` - Media conversion (video_to_mp3)

**Configuration Backup System** (`copy_configuration`):
- Archives dotfiles: `.zshrc`, `.zshenv`, `.zprofile`, `.xinitrc`, `.Xresources`
- Copies `.config` subdirectories (excluding heavy apps like GIMP, VSCodium, etc.)
- Backs up all scripts from `~/.local/bin` subdirectories
- Copies fonts from `~/.local/share/fonts`
- Target directory: `~/.local/src/archrice`

## Script Categories

**Display Management**:
- `hdmi-auto-enable`: Auto-detects and enables HDMI displays above primary monitor (logs to `/var/log/hdmi-auto-enable.log`)
- `change_resolution`: Resolution switcher
- `random_wallpaper`: Sets random wallpaper from `~/wallpapers/curated/` on Virtual-1 display
- `wallpaper_menu`: Interactive wallpaper selector from `~/.local/src/wallpaperDL/screensaver`

**System Launchers**:
- `script_menu`: Nested dmenu for selecting and executing scripts from `~/.local/bin/*`
- `power_menu`: Shutdown/reboot/exit-to-tty menu
- `search_directory`: Types `cd` command to navigate to selected directory (uses xdotool)
- `shortcut_menu`: Reference guide for DWM keybindings

**Media Conversion**:
- `video_to_mp3`: Converts video to MP3 (usage: `./video_to_mp3 "file.mkv"`)
- `md_to_pdf`: Converts Markdown to PDF using pandoc with Trebuchet MS font

**Other Utilities**:
- `homeserver_login`: SSH/login to home server
- `mount_hyperv`: Mount Hyper-V shares
- `reload_xresources`: Reload X resources
- `update_keyring`: Update system keyring
- `screen_key`: Screenkey launcher

## Development Notes

**Shell Compatibility**: Mix of `#!/bin/sh` (POSIX) and `#!/bin/bash` scripts. Use `#!/bin/sh` for simple utilities, `#!/bin/bash` when bash-specific features are needed (arrays, `[[`, etc.).

**Dmenu Integration**: Most interactive scripts use dmenu with common flags:
- `-i`: Case-insensitive matching
- `-l N`: Show N lines
- `-p "prompt"`: Set prompt text

**Path Assumptions**:
- Scripts assume location at `~/.local/bin/system`
- Wallpapers stored at `~/wallpapers/curated/` or `~/.local/src/wallpaperDL/screensaver`
- Configuration backup target: `~/.local/src/archrice`

**Display Configuration**: Scripts reference specific displays:
- Primary display detected via `xrandr | grep "primary"`
- HDMI auto-enabled above primary display
- Virtual-1 used for wallpapers (VM/virtual display)
