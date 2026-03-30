#!/bin/bash

# ╭────────────────────────────────────────────────────────╮
# │                  Setup ginit.vim Script                │
# │                                                          │
# │  This script creates the ginit.vim file for Neovide    │
# │  GUI configuration, ensuring proper font settings.     │
# ╰────────────────────────────────────────────────────────╯

set -e

# Configuration
NVIM_CONFIG_DIR="${HOME}/.config/nvim"
GINIT_FILE="${NVIM_CONFIG_DIR}/ginit.vim"
FONT_NAME="Maple Mono NF CN"
FONT_SIZE="14"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

# Print colored message
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Create ginit.vim content
create_ginit_content() {
    cat << 'EOF'
" ╭────────────────────────────────────────────────────────╮
" │               Neovim GUI Configuration                 │
" │                                                          │
" │  This file is loaded after init.lua when running       │
" │  in a GUI client (e.g., Neovide).                      │
" ╰────────────────────────────────────────────────────────╯

" Set guifont explicitly for Neovide
" Font name with escaped spaces for Vimscript
set guifont=Maple\ Mono\ NF\ CN:h14

" Load Neovide-specific configuration from Lua module
lua require('config.neovide')

" Additional GUI-specific settings can be added below
EOF
}

# Main function
main() {
    print_info "Setting up ginit.vim for Neovide..."

    # Check if Neovim config directory exists
    if [[ ! -d "${NVIM_CONFIG_DIR}" ]]; then
        print_info "Creating Neovim config directory: ${NVIM_CONFIG_DIR}"
        mkdir -p "${NVIM_CONFIG_DIR}"
    fi

    # Check if ginit.vim already exists
    if [[ -f "${GINIT_FILE}" ]]; then
        print_warn "ginit.vim already exists at ${GINIT_FILE}"
        read -p "Do you want to overwrite it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Skipping... ginit.vim was not modified."
            exit 0
        fi
        print_info "Backing up existing ginit.vim..."
        cp "${GINIT_FILE}" "${GINIT_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Create ginit.vim
    print_info "Creating ginit.vim at ${GINIT_FILE}..."
    create_ginit_content > "${GINIT_FILE}"

    # Verify file was created
    if [[ -f "${GINIT_FILE}" ]]; then
        print_info "✓ ginit.vim created successfully!"
        print_info "Font configured: ${FONT_NAME}:${FONT_SIZE}"
        print_info ""
        print_info "To use these settings, restart Neovide."
    else
        print_error "Failed to create ginit.vim"
        exit 1
    fi
}

# Run main function
main "$@"
