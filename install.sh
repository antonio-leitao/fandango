#!/bin/bash

# Stop the script if any command fails
set -e

# --- Configuration ---
GITHUB_USER="antonio-leitao"
REPO_NAME="fandango"
BRANCH="master"

# --- Constants ---
BASE_URL="https://raw.githubusercontent.com/${GITHUB_USER}/${REPO_NAME}/${BRANCH}"
ALACRITTY_THEME_FILE="alacritty/fandango.yaml"
NVCHAD_THEME_FILE="base46/fandango.lua"

# --- Color Definitions ---
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'
C_BOLD='\033[1m'

# --- Helper Functions ---
info() { echo -e "${C_BLUE}${C_BOLD}INFO:${C_RESET} $1"; }
success() { echo -e "${C_GREEN}${C_BOLD}SUCCESS:${C_RESET} $1"; }
warn() { echo -e "${C_YELLOW}${C_BOLD}WARN:${C_RESET} $1"; }
error() { echo -e "${C_RED}${C_BOLD}ERROR:${C_RESET} $1" >&2; }

# Function to download a file from the repo
download_file() {
    local file_path="$1"
    local destination="$2"
    local url="${BASE_URL}/${file_path}"

    info "Downloading ${file_path} from ${url}..."
    # Use curl to download. -f fails on 404, -s is silent, -L follows redirects.
    if ! curl -fsSL "${url}" -o "${destination}"; then
        error "Failed to download ${file_path}. Please check the URL and your connection."
        exit 1
    fi
}


# --- Main Script ---
echo -e "${C_BLUE}${C_BOLD}--- Fandango Theme Installer ---${C_RESET}"

# --- 1. Install Alacritty Theme ---
info "Checking for Alacritty..."
if command -v alacritty &> /dev/null; then
    ALACRITTY_THEME_DIR="$HOME/.config/alacritty/themes"
    info "Alacritty found. Installing theme..."

    mkdir -p "$ALACRITTY_THEME_DIR"
    download_file "${ALACRITTY_THEME_FILE}" "${ALACRITTY_THEME_DIR}/${ALACRITTY_THEME_FILE}"

    success "Theme installed to ${C_BOLD}${ALACRITTY_THEME_DIR}/${ALACRITTY_THEME_FILE}${C_RESET}"
    echo -e "\n${C_BOLD}Action required for Alacritty:${C_RESET}"
    echo "To enable the theme, add this line to your alacritty.toml (or .yml):"
    echo -e "${C_YELLOW}import = [ \"~/.config/alacritty/themes/fandango.yaml\" ]${C_RESET}\n"
else
    warn "Alacritty command not found in your PATH. Skipping Alacritty installation."
fi

# --- 2. Install NvChad Theme ---
info "Checking for NvChad..."
NVCHAD_CONFIG_DIR="$HOME/.config/nvim"
if [ -d "$NVCHAD_CONFIG_DIR" ] && [ -f "$NVCHAD_CONFIG_DIR/init.lua" ]; then
    NVCHAD_THEME_DIR="$NVCHAD_CONFIG_DIR/lua/custom/themes"
    info "NvChad installation found. Installing theme..."

    mkdir -p "$NVCHAD_THEME_DIR"
    download_file "${NVCHAD_THEME_FILE}" "${NVCHAD_THEME_DIR}/${NVCHAD_THEME_FILE}"
    
    success "Theme safely installed to ${C_BOLD}${NVCHAD_THEME_DIR}/${NVCHAD_THEME_FILE}${C_RESET}"
    echo -e "\n${C_BOLD}Action required for NvChad:${C_RESET}"
    echo "Edit your chadrc file (${C_BOLD}~/.config/nvim/lua/chadrc.lua${C_RESET}) and set:"
    echo -e "${C_YELLOW}  M.ui = { theme = \"fandango\" }${C_RESET}"
else
    warn "NvChad configuration not found. Skipping NvChad installation."
fi

echo -e "\n${C_GREEN}${C_BOLD}--- Installation Complete ---${C_RESET}"
echo "Please follow the instructions printed above to activate your new theme!"
