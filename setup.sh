# !/bin/bash
#
# Dotfiles configurator script by @7ir3



################################################################################
# GLOBAL VARIABLES
#
# NOTE: Edit the following variables to match your desired system configuration.

DOTNAME=".999666333"                          # Dotfiles repository name
DOTPATH="${HOME}/${DOTNAME}"                  # Dotfiles repository path

FFPATH=""                                     # FastFetch path
TMUXPATH="${DOTPATH}/tmux"                    # Tmux path
KANATAPATH="${DOTPATH}/kanata"                # Kanata path

################################################################################
################################################################################



################################################################################
# FUNCTIONS
#
# NOTE: Do not edit the following script unless you know what you are doing.
# --- Detect OS {macOS/Arch Linux}
detect_os() {
  [[ -f /etc/arch-release ]] && return 0      # Arch Linux
  [[ "$OSTYPE" == "darwin"* ]] && return 1    # macOS
  return 255                                  # Unsupported OS
}

################################################################################
################################################################################



################################################################################
# MAIN SCRIPT
#
# NOTE: Do not edit the following script unless you know what you are doing.

# --- Requirements
detect_os  # Detect OS
os=$?      # Catch return value
case $os in
  0)
    ./tmux/setup.sh "archlinux" $DOTPATH $TMUXPATH
    ./kanata/setup.sh "archlinux" $DOTPATH $TMUXPATH ;;
  1)
    ./tmux/setup.sh "macos" $DOTPATH $TMUXPATH
    ./kanata/setup.sh "macos" $DOTPATH $TMUXPATH ;;
  *) 
    echo "Unsupported OS" && exit 1 ;;        # Exit if OS is unsupported
esac

sudo reboot now

exit 0
