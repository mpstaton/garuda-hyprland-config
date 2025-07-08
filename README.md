# Garuda Hyprland Configuration

This repository contains my complete Garuda Linux Hyprland configuration backup, including all ~/.config files, UI scaling fixes for high-DPI displays, and custom desktop files.

# Keeping it Updated:
•  Just run `./sync-config.sh` whenever you make config changes
•  The script will handle everything automatically!

## System Informationw

- **OS**: Garuda Linux (Hyprland edition)
- **Display**: 4K (3840x2160) @ 144Hz with 1.25x scaling
- **Window Manager**: Hyprland
- **Status Bar**: Waybar
- **Terminal**: Warp (with custom scaling)
- **Total Config Directories**: 65+ applications (cleaned of sensitive data)

## Directory Structure

```
├── hypr/                    # Hyprland configuration (legacy)
│   ├── hyprland.conf       # Main Hyprland config
│   ├── hypridle.conf       # Idle management
│   ├── hyprstart           # Startup script
│   └── scripts/            # Custom scripts
├── dotconfig/              # Complete ~/.config backup (65+ apps)
│   ├── hypr/               # Hyprland configuration
│   ├── waybar/             # Status bar configuration
│   ├── kitty/              # Terminal emulator
│   ├── nvim/               # Neovim configuration
│   ├── warp-terminal/      # Warp terminal settings
│   ├── fish/               # Fish shell
│   ├── foot/               # Terminal emulator
│   ├── starship.toml       # Shell prompt configuration
│   ├── gtk-*/              # GTK themes and settings
│   ├── qt5ct/ & qt6ct/     # Qt theming
│   ├── mako/               # Notification daemon
│   ├── wofi/               # App launcher
│   ├── swaylock/           # Lock screen
│   ├── swaync/             # Notification center
│   ├── ranger/             # File manager
│   ├── btop/               # System monitor
│   ├── helix/              # Text editor
│   ├── mpv/                # Media player
│   ├── vlc/                # VLC media player
│   ├── alacritty/          # Terminal emulator
│   ├── geany/              # Text editor
│   ├── Thunar/             # File manager
│   ├── libreoffice/        # Office suite
│   ├── microsoft-edge-dev/ # Edge browser
│   ├── google-chrome-*/    # Chrome variants
│   ├── vivaldi-*/          # Vivaldi browser
│   ├── Windsurf/           # Code editor
│   ├── wpaperd/            # Wallpaper daemon
│   ├── systemd/            # User systemd services
│   ├── psd/                # Profile sync daemon
│   ├── garuda*/            # Garuda Linux tools
│   ├── nwg-*/              # NWG suite apps
│   ├── Kvantum/            # Qt theme engine
│   └── ... (40+ more apps)
├── desktop-files/          # Custom .desktop files with scaling fixes
│   ├── dev.warp.Warp.desktop    # Warp terminal (scaled down)
│   ├── obsidian.desktop         # Obsidian (scaled up)
│   └── ...
├── other-configs/          # Legacy config files
│   ├── .bashrc
│   ├── .zshrc
│   └── waybar/             # Waybar configuration
└── scripts/                # Custom scripts
```

## Key Features

### 1. Per-Application UI Scaling
- **Warp Terminal**: Scaled down (1.0x) for crisp text
- **Obsidian**: Scaled up (1.5x) for better readability
- **System Default**: 1.25x scaling for 4K display

### 2. Hyprland Window Rules
- Custom window sizing for applications
- Floating window controls
- Workspace management

### 3. High-DPI Display Optimization
- 4K display support with proper scaling
- Per-application scaling controls
- Consistent UI across different app types

## Installation

⚠️ **IMPORTANT**: This is a complete system configuration backup. **DO NOT** blindly copy everything to your system. Instead, selectively copy configurations you need.

🔒 **SECURITY NOTE**: The following sensitive data has been removed from this backup:
- API keys and tokens from VS Code history files
- 1Password configuration and data
- Environment files (.env)
- Go telemetry tokens
- Any other files containing credentials or secrets

### 1. Backup Current Configuration
```bash
# Create timestamped backup
cp -r ~/.config ~/.config.backup-$(date +%Y%m%d-%H%M%S)
cp -r ~/.local/share/applications ~/.local/share/applications.backup-$(date +%Y%m%d-%H%M%S)
```

### 2. Selective Configuration Restore

#### Option A: Restore Specific Applications
```bash
# Example: Restore only Hyprland configuration
cp -r dotconfig/hypr ~/.config/

# Example: Restore only Waybar
cp -r dotconfig/waybar ~/.config/

# Example: Restore terminal configurations
cp -r dotconfig/kitty ~/.config/
cp -r dotconfig/warp-terminal ~/.config/
```

#### Option B: Restore Everything (DANGEROUS)
```bash
# Only do this if you're sure!
cp -r dotconfig/* ~/.config/
```

### 3. Apply Custom Desktop Files
```bash
cp desktop-files/* ~/.local/share/applications/
update-desktop-database ~/.local/share/applications
```

### 4. Apply Shell Configurations
```bash
cp other-configs/.bashrc ~/
cp other-configs/.zshrc ~/
```

### 5. Reload Services
```bash
hyprctl reload
systemctl --user restart waybar
```

## UI Scaling Guide

### Environment Variables for Scaling

| Variable | Purpose | Values |
|----------|---------|--------|
| `GDK_SCALE` | GTK applications | 1.0, 1.25, 1.5, 2.0 |
| `QT_SCALE_FACTOR` | Qt applications | 1.0, 1.25, 1.5, 2.0 |
| `ELECTRON_SCALE` | Electron apps | 1.0, 1.25, 1.5, 2.0 |

### Electron App Scaling
For Electron apps (VS Code, Discord, Obsidian), use:
```bash
--force-device-scale-factor=1.5
```

### Example Desktop File
```ini
[Desktop Entry]
Name=MyApp
Exec=env GDK_SCALE=1.5 QT_SCALE_FACTOR=1.5 myapp --force-device-scale-factor=1.5
```

## Troubleshooting

### UI Too Small
- Increase scaling values in desktop files
- Common values: 1.25, 1.5, 1.75, 2.0

### UI Too Large
- Decrease scaling values in desktop files
- Use values like 0.8, 1.0

### Window Sizing Issues
- Check Hyprland window rules in `hypr/hyprland.conf`
- Ensure floating windows have proper size rules

## Monitor Configuration

Current monitor setup:
```
monitor = eDP-2, 3840x2160@144.00101, 0x0, 1.25
```

## Keybindings

See `hypr/hyprland.conf` for complete keybinding list.

Key shortcuts:
- `Super + Return`: Kitty terminal
- `Super + T`: Fullscreen Kitty
- `Super + F1`: Firefox
- `Super + Shift + R`: Reload Hyprland

## Sync Script

The `sync-config.sh` script automates the process of updating this repository with your current configuration:

```bash
# Run the sync script
./sync-config.sh

# Then commit the changes
git add .
git commit -m "Update configuration $(date +%Y-%m-%d)"
git push
```

### What the sync script does:
- ✅ Copies all important configuration directories
- ✅ Automatically removes sensitive data (API keys, passwords, etc.)
- ✅ Updates desktop files with scaling fixes
- ✅ Updates README with current directory count
- ✅ Provides colored output and progress feedback
- ✅ Handles missing directories gracefully

### Sensitive data automatically removed:
- Environment files (`.env`)
- API keys and tokens
- Browser local storage and session data
- 1Password data
- VS Code history files
- Credentials and secrets

## Credits

- Garuda Linux team for the base configuration
- Hyprland community for window management
- Various scaling solutions adapted for high-DPI displays
