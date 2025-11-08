# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a Garuda Linux Hyprland configuration backup repository containing 65+ application configurations optimized for a 4K display (3840x2160 @ 144Hz) with 1.25x scaling. It serves as a versioned backup of a complete desktop environment with automated syncing and sensitive data removal.

## Essential Commands

### Configuration Sync
```bash
# Sync current system configuration to repository (primary workflow)
./sync-config.sh

# After sync, review and commit changes
git status
git add .
git commit -m "Update configuration $(date +%Y-%m-%d)"
git push
```

### Hyprland Management
```bash
# Reload Hyprland configuration
hyprctl reload

# Restart Waybar status bar
systemctl --user restart waybar

# Test application with scaling
gtk-launch myapp
```

### Configuration Deployment

**Symbolic links (recommended for active development):**
```bash
# Link configs so repository remains source of truth
ln -sf ~/code/garuda-hyprland-config/dotconfig/hypr ~/.config/hypr
ln -sf ~/code/garuda-hyprland-config/dotconfig/waybar ~/.config/waybar

# Link desktop files with scaling fixes
ln -sf ~/code/garuda-hyprland-config/desktop-files/dev.warp.Warp.desktop ~/.local/share/applications/
update-desktop-database ~/.local/share/applications
```

**Copy (for one-time restoration):**
```bash
# Copy configs from repo to system (creates independent copies)
cp -r dotconfig/hypr ~/.config/
cp -r dotconfig/waybar ~/.config/

cp desktop-files/* ~/.local/share/applications/
update-desktop-database ~/.local/share/applications
```

## Architecture Overview

### Directory Layout
- **dotconfig/** - Complete ~/.config backup (65+ apps), sensitive data removed during sync
- **hypr/** - Legacy Hyprland config (reference only; active config in dotconfig/hypr/)
- **desktop-files/** - Custom .desktop files with per-app UI scaling fixes for 4K display
- **other-configs/** - Shell configurations (.bashrc, .zshrc)
- **scripts/** - Utility scripts (lock.sh, screenshot helpers, idle inhibitor)

### Configuration Hierarchy
1. **Primary**: `dotconfig/hypr/hyprland.conf` (active Hyprland config)
2. **Monitor**: 4K @ 1.25x base scaling (line 15: `monitor = eDP-2, 3840x2160@144.00101, 0x0, 1.25`)
3. **Status bar**: `dotconfig/waybar/config` (Waybar with custom modules)
4. **Window rules**: Per-application positioning and scaling (e.g., Warp terminal at 2000x1200 floating)
5. **Startup**: wpaperd (wallpaper), waybar (status bar), nm-applet (network)

### The sync-config.sh Script

**Core behavior:**
- Uses `safe_copy()` and `safe_copy_file()` functions to handle missing directories gracefully
- Automatically removes sensitive data via `clean_sensitive_data()`:
  - Pattern-based removal: .env, .key, .pem, *secret*, *credential*, *token*
  - Directory removal: 1Password/, Code/*/User/History/, go/telemetry/
  - Browser data: Local Storage, Session Storage, databases, IndexedDB
- Auto-updates README.md with current directory count
- Colored output (GREEN ✓, YELLOW ⚠, RED ✗) for user feedback
- Exits on any error (`set -e`)

**Files never tracked:**
- API keys, tokens, secrets, credentials
- Browser session and local storage
- 1Password data
- Environment files
- VS Code history files

## Display Scaling System

### The Problem
Linux applications don't uniformly handle HiDPI rendering. With 4K at 1.25x base scaling:
- Some apps scale too large (fonts become massive)
- Some apps scale too small (UI elements tiny)
- Each app type (GTK, Qt, Electron) needs individual tuning

### Solution: Per-Application Scaling via Desktop Files

**Environment variables:**
- `GDK_SCALE` - GTK applications (GNOME apps)
- `QT_SCALE_FACTOR` - Qt applications (KDE apps)
- `--force-device-scale-factor` - Electron apps (VS Code, Discord, Obsidian)
- `ELECTRON_SCALE` - Alternative Electron variable

**Common values:**
- 0.8x - Apps with very large default UI
- 0.9x - Apps with slightly large UI (Warp terminal)
- 1.0x - Perfect at base scaling
- 1.25x - Match system default
- 1.5x - Reading/writing apps needing larger UI (Obsidian)

**Example implementations:**
```ini
# Warp terminal (scaled down to 0.9x for crisp text)
Exec=env GDK_SCALE=0.9 QT_SCALE_FACTOR=0.9 warp-terminal --force-device-scale-factor=0.9 %U

# Obsidian (scaled up to 1.5x for readability)
Exec=env GDK_SCALE=1.5 QT_SCALE_FACTOR=1.5 ELECTRON_SCALE=1.5 /usr/bin/obsidian --force-device-scale-factor=1.5 %U
```

### Workflow for Adding Per-App Scaling
1. Find original desktop file: `find /usr/share/applications -name "*appname*.desktop"`
2. Copy to repo: `cp /usr/share/applications/myapp.desktop ~/code/garuda-hyprland-config/desktop-files/`
3. Edit Exec= line to add environment variables
4. Link to system: `ln -sf ~/code/garuda-hyprland-config/desktop-files/myapp.desktop ~/.local/share/applications/`
5. Update database: `update-desktop-database ~/.local/share/applications`
6. Test: `gtk-launch myapp`

## Development Patterns

### Configuration Management Strategy

**Two-way relationship:**
1. **Repository → System**: Via symlinks or copy (for deployment)
2. **System → Repository**: Via `./sync-config.sh` (for backup)

**Use symlinks when:**
- Repository should be single source of truth
- Actively developing/tweaking configurations
- Want changes reflected immediately in version control

**Use copying when:**
- One-time restoration after fresh install
- Testing experimental changes without affecting repo
- Want independent configs on multiple machines

### Adding New Application Configurations
1. Configure application on live system first
2. Run `./sync-config.sh` to sync to repository
3. Script automatically handles new directories
4. README.md directory count auto-updates
5. Commit with descriptive message

### Creating Scaled Desktop Files
1. Copy from `/usr/share/applications/` to `desktop-files/`
2. Modify `Exec=` line with scaling environment variables
3. Use `env` prefix for multiple variables
4. Update desktop database after installing to `~/.local/share/applications/`

### Modifying sync-config.sh
Script uses these functions:
- `safe_copy()` - For directories (creates parent dirs, handles missing sources)
- `safe_copy_file()` - For individual files
- `clean_sensitive_data()` - Security filtering (add new patterns here)
- Color codes: `$GREEN`, `$YELLOW`, `$RED`, `$BLUE`, `$NC` (no color)

### Window Rules in Hyprland
Located in `dotconfig/hypr/hyprland.conf`, using format:
```
windowrulev2 = float, class:^(app.class.Name)$
windowrulev2 = size WIDTH HEIGHT, class:^(app.class.Name)$
windowrulev2 = center, class:^(app.class.Name)$
```

Find app class with: `hyprctl clients`

## Key Keybindings

Main modifier: `$mainMod = SUPER`

**Terminals:**
- SUPER + Return: Kitty (font_size=13)
- SUPER + T: Fullscreen Kitty (font_size=18)

**Window Management:**
- SUPER + Q: Close window
- SUPER + SHIFT + Space: Toggle floating
- SUPER + F: Fullscreen
- SUPER + R + arrows: Resize mode

**Applications:**
- SUPER + F1: FireDragon browser
- SUPER + F2: Thunderbird
- SUPER + F3: Thunar file manager
- SUPER + F4: Geany editor

**System:**
- SUPER + SHIFT + R: Reload Hyprland
- Print: Screenshot with swappy

**Workspaces:**
- SUPER + [1-9]: Switch to workspace
- SUPER + SHIFT + [1-9]: Move window to workspace (silent)
- ALT + SHIFT + [1-9]: Move to workspace with window

## Configuration Restoration Guidelines

⚠️ **Never blindly copy entire dotconfig/** - This is a complete 65+ application backup.

**Complete restoration workflow:**
1. Backup existing configs: `cp -r ~/.config ~/.config.backup-$(date +%Y%m%d-%H%M%S)`
2. Choose deployment method (symlink vs copy - see above)
3. Deploy selected configurations
4. Reload services: `hyprctl reload && systemctl --user restart waybar`

## System Context

- **OS**: Garuda Linux (Arch-based, Hyprland edition)
- **Window Manager**: Hyprland (Wayland compositor)
- **Status Bar**: Waybar
- **Display**: 4K (3840x2160) @ 144Hz with 1.25x scaling
- **Terminal**: Warp (primary), Kitty, Foot, Alacritty
- **Shell**: Fish with Starship prompt
- **Editors**: Neovim, Helix, Geany
- **File Managers**: Thunar, Ranger
- **Theming**: GTK 2/3/4, Qt5ct/Qt6ct, Kvantum
- **Notifications**: Mako, SwayNC
- **Launcher**: Wofi, nwg-drawer

## Important Configuration Files

- `dotconfig/hypr/hyprland.conf` - Main Hyprland config (monitor, keybinds, window rules)
- `dotconfig/waybar/config` - Waybar modules and layout
- `desktop-files/dev.warp.Warp.desktop` - Warp terminal scaling (0.9x)
- `desktop-files/obsidian.desktop` - Obsidian scaling (1.5x)
- `sync-config.sh` - Configuration sync automation
