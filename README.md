# Dotfiles

Personal configuration files for my development environment. These dotfiles can be applied using [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html).

## Installation

```bash
stow -t ~/ .
```

## Tools & Configuration

This repository includes configuration for:

### Core Tools
- **Fish Shell** - Modern shell with autocompletion and syntax highlighting
- **Neovim** - Extensible text editor with LSP support
- **Tmux** - Terminal multiplexer for session management
- **Git** - Version control with custom helpers and aliases

### Terminal & UI
- **Ghostty** - Fast, native terminal emulator (replaced WezTerm)
- **Starship** - Cross-shell prompt
- **SketchyBar** - macOS status bar replacement
- **AeroSpace** - Tiling window manager for macOS

### Utilities
- **Yazi** - Terminal file manager
- **Atuin** - Shell history sync and search
- **FZF** - Fuzzy finder for files and commands

## Requirements

- git
- ghostty
- fish
- stow
- tmux
- neovim
- starship (optional)
- aerospace (macOS only)
- sketchybar (macOS only)
