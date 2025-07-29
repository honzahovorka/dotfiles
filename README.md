# Dotfiles

Personal configuration files for my development environment, organized for multi-OS support. These dotfiles use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) for symlink management.

## Quick Start

### Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/honzahovorka/dotfiles.git
cd dotfiles

# Preview what would be installed (dry-run)
./install.sh --dry-run macos
./install.sh --dry-run arch

# Install for your OS
./install.sh macos
./install.sh arch
```

### Manual Installation

```bash
# Install common configs (works on all systems)
stow common

# Install OS-specific configs
stow macos    # on macOS
stow arch     # on Arch Linux
```

## Repository Structure

This repository is organized into OS-specific modules:

```
dotfiles/
├── common/          # Cross-platform configurations
│   ├── .config/     # XDG config directory
│   │   ├── nvim/    # Neovim configuration
│   │   ├── fish/    # Fish shell configuration
│   │   ├── ghostty/ # Ghostty terminal configuration
│   │   └── ...      # Other common tools
│   ├── .gitconfig   # Git configuration
│   ├── .tmux.conf   # Tmux configuration
│   └── ...
├── macos/           # macOS-specific configurations
│   ├── .config/
│   │   └── sketchybar/  # SketchyBar configuration
│   └── .aerospace.toml  # AeroSpace window manager
├── arch/            # Arch Linux-specific configurations
│   └── .config/
│       ├── hypr/    # Hyprland window manager configuration
│       ├── waybar/  # Waybar status bar configuration
│       ├── rofi/    # Rofi application launcher
│       └── dunst/   # Dunst notification daemon
└── install.sh       # Automated installation script
```

## Installation Script Options

The `install.sh` script supports several options:

```bash
# Show help
./install.sh --help

# Dry-run mode (preview changes without applying)
./install.sh --dry-run macos
./install.sh -n arch

# Install for specific OS (with automatic backup)
./install.sh macos
./install.sh arch
```

## Tools & Configuration

### Common (Cross-Platform)
- **Fish Shell** - Modern shell with autocompletion and syntax highlighting
- **Neovim** - Extensible text editor with LSP support
- **Tmux** - Terminal multiplexer for session management
- **Git** - Version control with custom helpers and aliases
- **Ghostty** - Fast, native terminal emulator
- **Starship** - Cross-shell prompt
- **Yazi** - Terminal file manager
- **Atuin** - Shell history sync and search
- **Custom Scripts** - Utility scripts in `.config/bin/`

### macOS-Specific
- **SketchyBar** - macOS status bar replacement
- **AeroSpace** - Tiling window manager for macOS

### Arch Linux-Specific
- **Hyprland** - Dynamic tiling Wayland compositor
- **Waybar** - Highly customizable status bar for Wayland
- **Rofi** - Application launcher and dmenu replacement
- **Dunst** - Lightweight notification daemon
- **Catppuccin Frappe Theme** - Consistent theming across all components

## Requirements

### Essential
- **GNU Stow** - For symlink management
- **Git** - For cloning and version control

### Common Tools
- **Fish Shell** - Modern shell
- **Neovim** - Text editor
- **Tmux** - Terminal multiplexer
- **Ghostty** - Terminal emulator
- **Starship** - Shell prompt (optional)

### Arch Linux-Specific
- **Hyprland** - Wayland compositor
- **Waybar** - Status bar
- **Rofi** - Application launcher
- **Dunst** - Notification daemon
- **Hyprpaper** - Wallpaper utility

### macOS-Specific
- **AeroSpace** - Tiling window manager
- **SketchyBar** - Status bar replacement

### Installation Commands

**macOS (Homebrew):**
```bash
brew install stow fish neovim tmux starship
brew install --cask ghostty
# For AeroSpace and SketchyBar, see their respective documentation
```

**Arch Linux:**
```bash
# Essential tools
sudo pacman -S stow fish neovim tmux starship

# Hyprland desktop environment
sudo pacman -S hyprland waybar rofi dunst hyprpaper

# Additional tools
sudo pacman -S brightnessctl playerctl wpctl
# Install ghostty from AUR or build from source
```

### Removing Configurations
```bash
# Remove specific package
stow -D common
stow -D macos

# Or remove all
stow -D common macos arch
```
