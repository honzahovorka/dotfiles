#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false
BACKUP_DIR="$SCRIPT_DIR/dotfiles-backup"
BACKUP_ENABLED=true
LOG_FILE="$SCRIPT_DIR/install.log"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOG_FILE"
}

# Function to log errors
log_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: $*" | tee -a "$LOG_FILE" >&2
}

usage() {
    echo "Usage: $0 [OPTIONS] [OS]"
    echo ""
    echo "Initialize dotfiles for a specific operating system"
    echo ""
    echo "Options:"
    echo "  -n, --dry-run       Show what would be installed without making changes"
    echo "  -b, --no-backup     Skip backing up existing dotfiles"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Arguments:"
    echo "  OS               Operating system (macos, arch)"
    echo ""
    echo "Examples:"
    echo "  $0 macos            # Install common + macOS configs (with backup)"
    echo "  $0 arch             # Install common + Arch configs (with backup)"
    echo "  $0 -n macos         # Show what would be installed for macOS"
    echo "  $0 --no-backup      # Install without backing up existing files"
    echo ""
    echo "Available packages:"
    echo "  common           Cross-platform configs (git, nvim, tmux, etc.)"
    echo "  macos            macOS-specific configs (sketchybar, aerospace)"
    echo "  arch             Arch Linux-specific configs"
}

check_stow() {
    if ! command -v stow &> /dev/null; then
        echo "Error: GNU Stow is not installed"
        echo ""
        echo "Install instructions:"
        echo "  macOS:  brew install stow"
        echo "  Arch:   pacman -S stow"
        if [[ "$DRY_RUN" == "false" ]]; then
            exit 1
        fi
    fi
}

get_package_files() {
    local package="$1"
    local package_dir="$SCRIPT_DIR/$package"

    if [[ ! -d "$package_dir" ]]; then
        return
    fi

    # Find all files in the package, excluding directories and git files
    find "$package_dir" -type f -not -path "*/\.git/*" | while read -r file; do
        # Get relative path from package directory
        local rel_path="${file#$package_dir/}"
        echo "$rel_path"
    done
}

stow_package() {
    local package="$1"

    if [[ ! -d "$SCRIPT_DIR/$package" ]]; then
        if [[ "$DRY_RUN" == "true" ]]; then
            echo "[DRY RUN] Warning: Package '$package' not found, would skip..."
        else
            echo "Warning: Package '$package' not found, skipping..."
        fi
        log_error "Package '$package' not found at $SCRIPT_DIR/$package"
        return 1
    fi

    log "Processing package: $package"

    if [[ "$DRY_RUN" == "true" ]]; then
        echo "[DRY RUN] Would install $package configs..."
        cd "$SCRIPT_DIR"
        echo "[DRY RUN] Command: stow -t '$HOME' '$package'"
        if command -v stow &> /dev/null; then
            echo "[DRY RUN] Stow output:"
            if ! stow -n -t "$HOME" "$package" 2>&1; then
                log_error "Dry-run stow failed for package: $package"
            fi
        fi
        echo "[DRY RUN] ✓ $package configs would be installed"
    else
        echo "Installing $package configs..."
        cd "$SCRIPT_DIR"

        log "Running: stow -t '$HOME' '$package'"

        # Run stow and check exit code properly
        local stow_output
        local stow_exit_code

        stow_output=$(stow -t "$HOME" "$package" 2>&1)
        stow_exit_code=$?

        echo "$stow_output" | tee -a "$LOG_FILE"

        if [[ $stow_exit_code -eq 0 ]]; then
            echo "✓ $package configs installed"
            log "Successfully installed package: $package"
        else
            log_error "Failed to install package: $package (exit code: $stow_exit_code)"
            echo "❌ Failed to install $package configs"
            echo "Stow output logged to $LOG_FILE"
            echo ""
            echo "This shouldn't happen after cleanup. Please check the log for details."
            return 1
        fi
    fi
}

main() {
    local os=""

    # Initialize log file
    echo "=== Dotfiles Installation Started at $(date) ===" > "$LOG_FILE"
    log "Script started with arguments: $*"

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -n|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            -*)
                echo "Error: Unknown option $1"
                usage
                exit 1
                ;;
            *)
                if [[ -z "$os" ]]; then
                    os="$1"
                else
                    echo "Error: Multiple OS arguments provided"
                    usage
                    exit 1
                fi
                shift
                ;;
        esac
    done

    if [[ "$DRY_RUN" == "true" ]]; then
        echo "🔍 DRY RUN MODE - No changes will be made"
        echo ""
    fi

    if [[ "$DRY_RUN" == "false" ]]; then
        echo "📝 Installation log: $LOG_FILE"
        echo ""
    fi

    # Check if OS argument was provided
    if [[ -z "$os" ]]; then
        log_error "No OS argument provided"
        echo "Error: OS argument is required"
        echo ""
        usage
        exit 1
    fi

    # Validate OS argument (but allow dry-run to proceed with invalid OS for testing)
    case "$os" in
        macos|arch)
            # Valid OS
            ;;
        *)
            if [[ "$DRY_RUN" == "false" ]]; then
                log_error "Unsupported OS: $os"
                echo "Error: Unsupported OS '$os'"
                echo "Supported: macos, arch"
                usage
                exit 1
            else
                echo "[DRY RUN] Warning: Unsupported OS '$os', but continuing in dry-run mode"
                log "Dry-run with unsupported OS: $os"
            fi
            ;;
    esac

    check_stow

    # Always install common configs
    if ! stow_package "common"; then
        if [[ "$DRY_RUN" == "false" ]]; then
            log_error "Failed to install common package, aborting"
            exit 1
        fi
    fi

    # Install OS-specific configs
    case "$os" in
        macos)
            if ! stow_package "macos"; then
                if [[ "$DRY_RUN" == "false" ]]; then
                    log_error "Failed to install macos package"
                    exit 1
                fi
            fi
            ;;
        arch)
            if ! stow_package "arch"; then
                if [[ "$DRY_RUN" == "false" ]]; then
                    log_error "Failed to install arch package"
                    exit 1
                fi
            fi
            ;;
        *)
            # This case should only be reached in dry-run mode due to earlier validation
            if [[ "$DRY_RUN" == "true" ]]; then
                echo "[DRY RUN] Would attempt to install '$os' package (unsupported)"
                log "Dry-run attempted unsupported OS package: $os"
            else
                log_error "Unsupported OS: $os"
                echo "Error: Unsupported OS '$os'"
                echo "Supported: macos, arch"
                usage
                exit 1
            fi
            ;;
    esac

    echo ""
    if [[ "$DRY_RUN" == "true" ]]; then
        echo "🔍 DRY RUN SUMMARY - What would be installed:"
        echo ""
        echo "Packages that would be installed:"
        echo "  ✓ common (cross-platform configs)"
        [[ "$os" == "macos" ]] && echo "  ✓ macos (sketchybar, aerospace)"
        [[ "$os" == "arch" ]] && echo "  ✓ arch (arch-specific configs)"
        echo ""
        echo "To actually install, run without --dry-run flag"
    else
        echo "🎉 Dotfiles installation complete!"
        echo ""
        echo "Installed packages:"
        echo "  ✓ common (cross-platform configs)"
        [[ "$os" == "macos" ]] && echo "  ✓ macos (sketchybar, aerospace)"
        [[ "$os" == "arch" ]] && echo "  ✓ arch (arch-specific configs)"
        echo ""
        echo "📝 Full installation log saved to: $LOG_FILE"
        log "Installation completed successfully"
    fi

    log "=== Dotfiles Installation Finished at $(date) ==="
}

main "$@"
