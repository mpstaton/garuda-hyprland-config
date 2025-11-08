# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Purpose

This is a Garuda Linux Hyprland configuration backup repository containing 65+ application configurations optimized for a 4K display (3840x2160 @ 144Hz) with 1.25x scaling. The repository serves as a versioned backup of a complete desktop environment configuration with automated syncing and sensitive data removal.

## Key Commands

### Configuration Sync
```bash
# Sync current system configuration to repository
./sync-config.sh

# Review and commit changes after sync
git status
git add .
git commit -m "Update configuration $(date +%Y-%m-%d)"
git push
```

### Hyprland Management
```bash
# Reload Hyprland configuration
hyprctl reload

# Restart Waybar (status bar)
systemctl --user restart waybar
```

### Configuration Management Strategy

⚠️ **IMPORTANT**: This repository is the **master copy** of all configurations.

You have two options for using these configurations:

**Option 1: Symbolic Links (RECOMMENDED for active development)**
```bash
# Link configs so this repo remains the source of truth
# Changes to live system automatically sync to repo
ln -sf ~/code/garuda-hyprland-config/dotconfig/hypr ~/.config/hypr
ln -sf ~/code/garuda-hyprland-config/dotconfig/waybar ~/.config/waybar

# Link desktop files
ln -sf ~/code/garuda-hyprland-config/desktop-files/dev.warp.Warp.desktop ~/.local/share/applications/
update-desktop-database ~/.local/share/applications
```

**Option 2: Copy (for one-time restoration or testing)**
```bash
# Copy configs from repo to system (creates independent copies)
cp -r dotconfig/hypr ~/.config/
cp -r dotconfig/waybar ~/.config/

# Copy desktop files
cp desktop-files/* ~/.local/share/applications/
update-desktop-database ~/.local/share/applications
```

**When to use each approach**:
- **Symbolic links**: When actively developing/modifying configs and want changes reflected in repo
- **Copy**: When restoring after fresh install or testing changes without affecting repo

## Architecture Overview

### Directory Structure

**dotconfig/** - Complete `~/.config` backup (65+ applications)
- Primary configurations synced from live system
- Sensitive data automatically removed during sync
- Includes: Hyprland, Waybar, terminals (Warp, Kitty, Foot), editors (Neovim, Helix), themes (GTK, Qt, Kvantum), and system services

**hypr/** - Legacy Hyprland configuration (kept for reference)
- Contains: `hyprland.conf`, `hypridle.conf`, `hyprstart`, and utility scripts
- Note: Active configuration is in `dotconfig/hypr/`

**desktop-files/** - Custom `.desktop` files with per-application UI scaling
- Contains scaling fixes for 4K displays
- Warp terminal scaled down (1.0x for crisp text)
- Obsidian scaled up (1.5x for readability)

**other-configs/** - Shell configurations (`.bashrc`, `.zshrc`)

### Configuration Hierarchy

1. **Primary config**: `dotconfig/hypr/hyprland.conf` - Active Hyprland configuration
2. **Monitor setup**: 4K display @ 1.25x base scaling (line 15 of hyprland.conf)
3. **Keybindings**: `$mainMod = SUPER` with extensive workspace and app shortcuts
4. **Window rules**: Special sizing for Warp terminal (2000x1200 floating) and Garuda tools
5. **Startup services**: wpaperd (wallpaper), waybar (status bar), nm-applet (network)

### The sync-config.sh Script

**Purpose**: Automates copying live system configs to repository with security cleaning

**Key behaviors**:
- Uses `safe_copy()` function to handle missing directories gracefully
- Removes sensitive files via `clean_sensitive_data()` function:
  - `.env`, `.key`, `.pem` files
  - `*secret*`, `*credential*`, `*token*` patterns
  - 1Password data, VS Code history, browser local storage
  - Go telemetry data
- Auto-updates README.md with current directory count
- Colored output (GREEN/YELLOW/RED) for user feedback
- Exits on any error (`set -e`)

**Files never tracked**:
- API keys, tokens, secrets, credentials
- Browser session data and local storage
- 1Password configuration
- Environment files

## Display Scaling Configuration

### Base System
- Monitor: `eDP-2, 3840x2160@144.00101, 0x0, 1.25`
- Default scaling: 1.25x for 4K display

### Per-Application Scaling
Controlled via desktop files using environment variables:

```bash
# GTK applications
GDK_SCALE=1.5

# Qt applications  
QT_SCALE_FACTOR=1.5

# Electron apps
--force-device-scale-factor=1.5
```

**Key scaling examples**:
- Warp Terminal: Scaled to 1.0x (desktop file: `dev.warp.Warp.desktop`)
- Obsidian: Scaled to 1.5x (desktop file: `obsidian.desktop`)

### Window Rules for Warp
In `hyprland.conf`:
```
windowrulev2 = float, class:^(dev.warp.Warp)$
windowrulev2 = size 2000 1200, class:^(dev.warp.Warp)$
windowrulev2 = center, class:^(dev.warp.Warp)$
```

## Important Keybindings

Main modifier: `SUPER`

**Terminals**:
- `SUPER + Return`: Kitty with font_size=13
- `SUPER + t`: Fullscreen Kitty with font_size=18
- `SUPER + SHIFT + Return`: edex-ui

**Window Management**:
- `SUPER + Q`: Close active window
- `SUPER + SHIFT + Space`: Toggle floating
- `SUPER + F`: Fullscreen
- `SUPER + R` then arrow keys: Resize mode

**Applications (Function keys)**:
- `SUPER + F1`: FireDragon browser
- `SUPER + F2`: Thunderbird
- `SUPER + F3`: Thunar file manager
- `SUPER + F4`: Geany editor

**System**:
- `SUPER + SHIFT + R`: Reload Hyprland
- Volume: XF86 keys (122/123 = decrease/increase)
- Print: Screenshot with swappy

**Workspaces**:
- `SUPER + [1-9]`: Switch to workspace
- `SUPER + SHIFT + [1-9]`: Move window to workspace (silent)
- `ALT + SHIFT + [1-9]`: Move to workspace with window

## Configuration Restoration Guidelines

⚠️ **Never blindly copy entire dotconfig/** - This is a complete 65+ application backup.

### Understanding the Two-Way Relationship

This repository can serve configurations in two ways:
1. **Repository → System** (via symlinks or copy)
2. **System → Repository** (via `./sync-config.sh`)

### Complete Restoration Workflow

**Step 1: Backup existing configs**
```bash
cp -r ~/.config ~/.config.backup-$(date +%Y%m%d-%H%M%S)
```

**Step 2: Choose your restoration method**

**Method A: Symbolic Links (repository as master)**
```bash
# This makes the repo the authoritative source
# Live system reads directly from repo
ln -sf ~/code/garuda-hyprland-config/dotconfig/hypr ~/.config/hypr
ln -sf ~/code/garuda-hyprland-config/dotconfig/waybar ~/.config/waybar
ln -sf ~/code/garuda-hyprland-config/dotconfig/kitty ~/.config/kitty
ln -sf ~/code/garuda-hyprland-config/dotconfig/warp-terminal ~/.config/warp-terminal

# Link desktop files for scaling
for file in ~/code/garuda-hyprland-config/desktop-files/*.desktop; do
    ln -sf "$file" ~/.local/share/applications/
done
update-desktop-database ~/.local/share/applications
```

**Method B: Copy (independent configs)**
```bash
# This creates separate copies
# Changes to live system won't affect repo until you run sync-config.sh
cp -r dotconfig/hypr ~/.config/
cp -r dotconfig/waybar ~/.config/
cp -r dotconfig/kitty ~/.config/
cp -r dotconfig/warp-terminal ~/.config/

# Copy desktop files
cp desktop-files/* ~/.local/share/applications/
update-desktop-database ~/.local/share/applications
```

**Step 3: Reload services**
```bash
hyprctl reload
systemctl --user restart waybar
```

### When to Use Each Method

**Use symbolic links when**:
- You want this repository to be the single source of truth
- You're actively developing/tweaking configurations
- You want changes reflected immediately in version control
- You edit configs directly and want them tracked

**Use copying when**:
- Doing a one-time restoration after fresh install
- Testing experimental changes without affecting the repo
- You prefer to manually sync with `./sync-config.sh`
- You want independent configs on multiple machines

## Development Patterns

### Adding New Configurations
When adding configurations for a new application:
1. Configuration should be added to live system first
2. Run `./sync-config.sh` to sync to repository
3. Script will automatically handle the new directory
4. README.md directory count will auto-update
5. Commit with descriptive message

### Desktop File Scaling
When creating new scaled desktop files:
1. Copy from `/usr/share/applications/` to `desktop-files/`
2. Modify `Exec=` line to include scaling environment variables
3. Use `env` prefix for multiple variables
4. Update desktop database after copying to `~/.local/share/applications/`

### Script Modifications
The `sync-config.sh` script uses:
- `safe_copy()` for directories (creates parent dirs, handles missing sources)
- `safe_copy_file()` for individual files
- `clean_sensitive_data()` for security (add new patterns here)
- Color codes: `GREEN`, `YELLOW`, `RED`, `BLUE`, `NC` (no color)

## System Context

- **OS**: Garuda Linux (Arch-based, Hyprland edition)
- **Window Manager**: Hyprland (Wayland compositor)
- **Status Bar**: Waybar with custom config (2400px width)
- **Terminal**: Warp (primary in Warp), Kitty, Foot, Alacritty
- **Shell**: Fish with Starship prompt
- **Editors**: Neovim, Helix, Geany
- **File Managers**: Thunar, Ranger
- **Theming**: GTK 2/3/4, Qt5ct/Qt6ct, Kvantum
- **Notification**: Mako, SwayNC
- **Launcher**: Wofi, nwg-drawer
