# !/bin/bash
#
# Tmux configurator script by @7ir3



################################################################################
# GLOBAL VARIABLES
# 
# NOTE: Do not edit the following variables unless you know what are you doing.

OS=$1          # Running operating system

DOTPATH=$2     # Dotfiles path
TMUXPATH=$3    # Tmux path

################################################################################
################################################################################



################################################################################
# MAIN SCRIPT
#
# NOTE: Do not edit the following script unless you know what you are doing.

case $OS in
  archlinux)
    sudo pacman -Sy --noconfirm bash bc \
	    zsh coreutils git \
	    jq playerctl                        # Dependencies
    paru -Sy --noconfirm nerd-fonts \
	    nerd-fonts-sf-mono-ligatures        # Nerd fonts (AUR)
    sudo pacman -Sy --noconfirm tmux ;;         # Tmux
  macos)
    brew install bash bc zsh \
	    coreutils gawk gh \
	    glab gsed jq \
	    nowplaying-cli                      # Dependencies
    brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
    brew install --cask \
	    font-monaspace-nerd-font \
	    font-noto-sans-symbols-2 \
	    font-sf-mono-nerd-font-ligaturized  # Nerd fonts
    brew install tmux ;;                        # Tmux
  *)
    echo "Unsupported OS: ${OS}" && exit 1 ;;   # Exit if OS is unsupported/unknow
esac

# --- Dynamic link tmux configuration
ln -sf $DOTPATH $TMUXPATH

# --- TPM (Tmux Plugin Manager)
mkdir -p "${TMUXPATH}/plugins"                  # Ensure 'plugins' exist inside of tmux path
git clone https://github.com/tmux-plugins/tpm "${TMUXPATH}/plugins/tpm"

exit 0
