# Garuda Hyprland Configuration

This repository contains my personal Garuda Linux Hyprland configuration files, including UI scaling fixes for high-DPI displays.

## System Information

- **OS**: Garuda Linux (Hyprland edition)
- **Display**: 4K (3840x2160) @ 144Hz with 1.25x scaling
- **Window Manager**: Hyprland
- **Status Bar**: Waybar
- **Terminal**: Warp (with custom scaling)

## Directory Structure

```
├── hypr/                    # Hyprland configuration
│   ├── hyprland.conf       # Main Hyprland config
│   ├── hypridle.conf       # Idle management
│   ├── hyprstart           # Startup script
│   └── scripts/            # Custom scripts
├── desktop-files/          # Custom .desktop files with scaling fixes
│   ├── dev.warp.Warp.desktop    # Warp terminal (scaled down)
│   ├── obsidian.desktop         # Obsidian (scaled up)
│   └── ...
├── other-configs/          # Other configuration files
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

### 1. Backup Current Configuration
```bash
cp -r ~/.config/hypr ~/.config/hypr.backup
cp -r ~/.local/share/applications ~/.local/share/applications.backup
```

### 2. Apply Hyprland Configuration
```bash
cp hypr/* ~/.config/hypr/
```

### 3. Apply Desktop Files
```bash
cp desktop-files/* ~/.local/share/applications/
update-desktop-database ~/.local/share/applications
```

### 4. Apply Other Configs
```bash
cp other-configs/.bashrc ~/
cp other-configs/.zshrc ~/
cp -r other-configs/waybar ~/.config/
```

### 5. Reload Hyprland
```bash
hyprctl reload
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

## Credits

- Garuda Linux team for the base configuration
- Hyprland community for window management
- Various scaling solutions adapted for high-DPI displays
