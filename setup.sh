# !/bin/bash
#
# Dotfiles configurator script by @7ir3

### MOVE THIS FILE TO THE DOTFILES REPOSITORY (REMEMBER FOR LATER) ###

################################################################################
# GLOBAL VARIABLES
#
# NOTE: Edit the following variables to match your desired system configuration.

DOTFILESNAME=".999666333"  # Dotfiles repository name

################################################################################
################################################################################



################################################################################
# FUNCTIONS
#
# NOTE: Do not edit the following script unless you know what you are doing.
# --- Detect OS {macOS/Arch Linux}
detect_os() {
  [[ -f /etc/arch-release ]] && return 0    # Arch Linux
  [[ "$OSTYPE" == "darwin"* ]] && return 1  # macOS
  return 255                                # Unsupported OS
}

################################################################################
################################################################################



################################################################################
# MAIN SCRIPT
#
# NOTE: Do not edit the following script unless you know what you are doing.

# ======  TMUX  ======
# --- Requirements
detect_os  # Detect OS
os=$?      # Catch return value
case $os in
  0) 
    sudo pacman -Sy --noconfirm bash bc coreutils git jq playerctl          # Install dependencies (Arch Linux)
    sudo pacman -Sy --noconfirm tmux ;;                                     # Install tmux (Arch Linux)
  1) 
    brew install --cask font-monaspace-nerd-font font-noto-sans-symbols-2   # Install fonts (macOS)
    brew install bash bc coreutils gawk gh glab gsed jq nowplaying-cli      # Install dependencies (macOS)
    brew install tmux ;;                                                    # Install tmux (macOS)
  *) 
    echo "Unsupported OS" && exit 1 ;;                                      # Exit if OS is unsupported
esac

# --- TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# --- Dynamic link tmux configuration
ln -sf "$HOME/${DOTFILESNAME}/tmux/" "$HOME/.config/tmux"
