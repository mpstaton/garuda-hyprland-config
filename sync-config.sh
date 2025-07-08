#!/bin/bash

# Garuda Hyprland Configuration Sync Script
# This script syncs your live configuration with the git repository

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$SCRIPT_DIR"

echo -e "${BLUE}🔄 Syncing Garuda Hyprland Configuration...${NC}"
echo "Repository: $REPO_DIR"
echo

# Function to log actions
log_action() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to safely copy directory
safe_copy() {
    local src="$1"
    local dest="$2"
    local desc="$3"
    
    if [[ -d "$src" ]]; then
        # Remove destination if it exists
        if [[ -d "$dest" ]]; then
            rm -rf "$dest"
        fi
        
        # Create parent directory if needed
        mkdir -p "$(dirname "$dest")"
        
        # Copy with preservation of attributes
        cp -r "$src" "$dest"
        log_action "Copied $desc"
    else
        log_warning "Source not found: $src"
    fi
}

# Function to safely copy file
safe_copy_file() {
    local src="$1"
    local dest="$2"
    local desc="$3"
    
    if [[ -f "$src" ]]; then
        # Create parent directory if needed
        mkdir -p "$(dirname "$dest")"
        
        # Copy file
        cp "$src" "$dest"
        log_action "Copied $desc"
    else
        log_warning "Source file not found: $src"
    fi
}

# Function to remove sensitive data patterns
clean_sensitive_data() {
    local dir="$1"
    
    echo -e "${BLUE}🔒 Cleaning sensitive data...${NC}"
    
    # Remove common sensitive file patterns
    find "$dir" -name "*.env" -type f -delete 2>/dev/null || true
    find "$dir" -name "*.key" -type f -delete 2>/dev/null || true
    find "$dir" -name "*.pem" -type f -delete 2>/dev/null || true
    find "$dir" -name "*secret*" -type f -delete 2>/dev/null || true
    find "$dir" -name "*credential*" -type f -delete 2>/dev/null || true
    find "$dir" -name "*token*" -type f -delete 2>/dev/null || true
    
    # Remove sensitive directories
    rm -rf "$dir/1Password" 2>/dev/null || true
    rm -rf "$dir/Code"*/User/History/ 2>/dev/null || true
    rm -rf "$dir/go/telemetry/" 2>/dev/null || true
    
    # Remove browser data that might contain sensitive info
    rm -rf "$dir/BraveSoftware/Brave-Browser/Default/Local Storage" 2>/dev/null || true
    rm -rf "$dir/BraveSoftware/Brave-Browser/Default/Session Storage" 2>/dev/null || true
    rm -rf "$dir/BraveSoftware/Brave-Browser/Default/databases" 2>/dev/null || true
    rm -rf "$dir/BraveSoftware/Brave-Browser/Default/IndexedDB" 2>/dev/null || true
    rm -rf "$dir/chromium"*/Default/Local\ Storage 2>/dev/null || true
    rm -rf "$dir/chromium"*/Default/Session\ Storage 2>/dev/null || true
    rm -rf "$dir/google-chrome"*/Default/Local\ Storage 2>/dev/null || true
    rm -rf "$dir/vivaldi"*/Default/Local\ Storage 2>/dev/null || true
    
    log_action "Cleaned sensitive data"
}

# Backup timestamp
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo -e "${BLUE}📁 Syncing configuration directories...${NC}"

# Sync Hyprland configuration
safe_copy ~/.config/hypr "$REPO_DIR/dotconfig/hypr" "Hyprland configuration"

# Sync Waybar configuration
safe_copy ~/.config/waybar "$REPO_DIR/dotconfig/waybar" "Waybar configuration"

# Sync terminal configurations
safe_copy ~/.config/warp-terminal "$REPO_DIR/dotconfig/warp-terminal" "Warp terminal"
safe_copy ~/.config/kitty "$REPO_DIR/dotconfig/kitty" "Kitty terminal"
safe_copy ~/.config/alacritty "$REPO_DIR/dotconfig/alacritty" "Alacritty terminal"
safe_copy ~/.config/foot "$REPO_DIR/dotconfig/foot" "Foot terminal"

# Sync shell configurations
safe_copy ~/.config/fish "$REPO_DIR/dotconfig/fish" "Fish shell"
safe_copy_file ~/.config/starship.toml "$REPO_DIR/dotconfig/starship.toml" "Starship prompt"

# Sync text editors
safe_copy ~/.config/nvim "$REPO_DIR/dotconfig/nvim" "Neovim"
safe_copy ~/.config/helix "$REPO_DIR/dotconfig/helix" "Helix editor"
safe_copy ~/.config/geany "$REPO_DIR/dotconfig/geany" "Geany editor"

# Sync file managers
safe_copy ~/.config/ranger "$REPO_DIR/dotconfig/ranger" "Ranger file manager"
safe_copy ~/.config/Thunar "$REPO_DIR/dotconfig/Thunar" "Thunar file manager"

# Sync system monitoring
safe_copy ~/.config/btop "$REPO_DIR/dotconfig/btop" "Btop system monitor"
safe_copy ~/.config/htop "$REPO_DIR/dotconfig/htop" "Htop system monitor"

# Sync UI/UX tools
safe_copy ~/.config/wofi "$REPO_DIR/dotconfig/wofi" "Wofi launcher"
safe_copy ~/.config/mako "$REPO_DIR/dotconfig/mako" "Mako notifications"
safe_copy ~/.config/swaync "$REPO_DIR/dotconfig/swaync" "SwayNC notifications"
safe_copy ~/.config/swaylock "$REPO_DIR/dotconfig/swaylock" "Swaylock"

# Sync theming
safe_copy ~/.config/gtk-2.0 "$REPO_DIR/dotconfig/gtk-2.0" "GTK 2.0 theme"
safe_copy ~/.config/gtk-3.0 "$REPO_DIR/dotconfig/gtk-3.0" "GTK 3.0 theme"
safe_copy ~/.config/gtk-4.0 "$REPO_DIR/dotconfig/gtk-4.0" "GTK 4.0 theme"
safe_copy ~/.config/qt5ct "$REPO_DIR/dotconfig/qt5ct" "Qt5 theme"
safe_copy ~/.config/qt6ct "$REPO_DIR/dotconfig/qt6ct" "Qt6 theme"
safe_copy ~/.config/Kvantum "$REPO_DIR/dotconfig/Kvantum" "Kvantum theme"

# Sync media players
safe_copy ~/.config/mpv "$REPO_DIR/dotconfig/mpv" "MPV media player"
safe_copy ~/.config/vlc "$REPO_DIR/dotconfig/vlc" "VLC media player"

# Sync other important configs
safe_copy ~/.config/git "$REPO_DIR/dotconfig/git" "Git configuration"
safe_copy ~/.config/systemd "$REPO_DIR/dotconfig/systemd" "Systemd user services"
safe_copy ~/.config/autostart "$REPO_DIR/dotconfig/autostart" "Autostart applications"
safe_copy ~/.config/environment.d "$REPO_DIR/dotconfig/environment.d" "Environment variables"

# Sync Garuda-specific tools
safe_copy ~/.config/garuda "$REPO_DIR/dotconfig/garuda" "Garuda tools"
safe_copy ~/.config/garuda-rani "$REPO_DIR/dotconfig/garuda-rani" "Garuda Rani"

# Sync desktop files
echo -e "${BLUE}📱 Syncing desktop files...${NC}"
safe_copy ~/.local/share/applications "$REPO_DIR/desktop-files" "Desktop files"

# Sync shell rc files
echo -e "${BLUE}🐚 Syncing shell configurations...${NC}"
safe_copy_file ~/.bashrc "$REPO_DIR/other-configs/.bashrc" "Bash configuration"
safe_copy_file ~/.zshrc "$REPO_DIR/other-configs/.zshrc" "Zsh configuration"

# Clean sensitive data
clean_sensitive_data "$REPO_DIR/dotconfig"

# Update directory count in README
echo -e "${BLUE}📝 Updating README...${NC}"
CONFIG_COUNT=$(find "$REPO_DIR/dotconfig" -mindepth 1 -maxdepth 1 -type d | wc -l)
sed -i "s/Total Config Directories.*applications.*/Total Config Directories**: ${CONFIG_COUNT}+ applications (cleaned of sensitive data)/" "$REPO_DIR/README.md"

echo
echo -e "${GREEN}✅ Configuration sync completed!${NC}"
echo -e "${BLUE}📊 Summary:${NC}"
echo "  • Synced ${CONFIG_COUNT}+ configuration directories"
echo "  • Cleaned sensitive data"
echo "  • Updated README.md"
echo
echo -e "${YELLOW}💡 Next steps:${NC}"
echo "  1. Review changes: git status"
echo "  2. Add files: git add ."
echo "  3. Commit: git commit -m 'Update configuration $(date +%Y-%m-%d)'"
echo "  4. Push: git push"
echo
echo -e "${BLUE}🔄 To run this script again: $0${NC}"
