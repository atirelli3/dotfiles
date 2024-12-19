# !/bin/bash
#
# Kanata configurator script by @7ir3



################################################################################
# GLOBAL VARIABLES
#
# NOTE: Do not edit the following variables unless you know what are you doing.

OS=$1                                           # Running operating system

DOTPATH=$2                                      # Dotfiles path
KANATAPATH=$3                                   # Kanata path

################################################################################
################################################################################



################################################################################
# MAIN SCRIPT
#
# NOTE: Do not edit the following script unless you know what you are doing.

case $OS in
  archlinux)
    paru -S --noconfirm kanata
  macos)
    brew install kanata
  *)
    echo "Unsupported OS: ${OS}" && exit 1 ;;   # Exit if OS is unsupported/unknow
esac

# --- Dynamic link kanata configuration
ln -sf $DOTHPATH $KANATAPATH

# --- Avoid using sudo
sudo groupadd uinput                            # Create a new group
sudo usermod -aG input $USER                    # Add your user to input
sudo usermod -aG uinput $USER                   # Add your user to uinput
sudo touch /etc/udev/rules.d/99-input.rules     # Create rules file
# Write rules
sudo echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' > /etc/udev/rules.d/99-input.rules 
sudo udevadm control --reload-rules             # Reload udev rules
sudo udevadm trigger                            # Reload udev rules
sudo modprobe uinput                            # Load uinput drivers

# --- Systemd daemon service
mkdir -p ~/.config/systemd/user                 # Daemon service directory
cp kanata.service ~/.config/systemd/user        # Copy service file
systemctl --user daemon-reload                  # Reload all daemons
systemctl --user enable kanata.service          # Enable service
systemctl --user start kanata.service           # Start service

exit 0
