#!/bin/bash

# Array of required packages
PACKAGES=(
    qtile
    git
    base-devel
    alacritty
    firefox
    nitrogen
    polkit
    volumeicon
    dunst
    picom
    lxsession
    redshift
    blueman
    xfce4-power-manager
    light-locker
    flameshot
    network-manager-applet
    ttf-font-awesome
    ttf-firacode-nerd
    lightdm
    thunar
    neofetch
    htop
    dmenu
    unzip
    wget
    vim
    lightdm-gtk-greeter
    xdg-user-dirs
    archlinux-wallpaper
    zsh
)

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as 'sudo ./install.sh'" 2>&1
    exit 1
fi

echo # _   __ _     _                  
echo #| | / /| |   (_)                 
echo #| |/ / | |    _ _ __  _   ___  __
echo #|    \ | |   | | '_ \| | | \ \/ /
echo #| |\  \| |___| | | | | |_| |>  < 
echo #\_| \_/\_____/_|_| |_|\__,_/_/\_\

username=$(id -u -n 1000)
home_dir=$(eval echo ~$username)

mkdir -p $home_dir/.config
mkdir -p $home_dir/.fonts
mkdir -p $home_dir/.config/qtile
mkdir -p $home_dir/.config/picom
mkdir -p $home_dir/.config/alacritty
mkdir -p $home_dir/.config/zsh
mkdir -p $home_dir/.cache
mkdir -p $home_dir/.cache/zsh
touch $home_dir/.cache/zsh/history
mkdir -p $home_dir/Downloads
chown -R $username:$username /home/$username

# make user directories
cd $home_dir
xdg-user-dirs-update


# Install the required packages
echo "Installing dependencies..."

pacman -Syu --needed "${PACKAGES[@]}" || {
    echo "Failed to install dependencies. Exiting."
    exit 1
}

# Copy the configuration files
echo "Copying configuration files..."

curl https://github.com/kaveen-lakmuthu/qtile/blob/main/config.py > $home_dir/.config/qtile/config.py || {
    echo "Failed to copy the configuration file. Exiting."
    exit 1
}
curl https://github.com/kaveen-lakmuthu/qtile/blob/main/autostart_once.sh > $home_dir/.config/qtile/autostart_once.sh || {
    echo "Failed to copy the autostart file. Exiting."
    exit 1
}
curl https://github.com/kaveen-lakmuthu/qtile/blob/main/qtilelogo.png > $home_dir/.config/qtile/qtilelogo.png || {
    echo "Failed to copy the qtile logo. Exiting."
    exit 1
}

# Copy picom configuration
curl https://github.com/kaveen-lakmuthu/k-picom/blob/main/picom.conf > $home_dir/.config/picom/picom.conf || {
    echo "Failed to copy the picom configuration file. Exiting."
    exit 1
}

# Copy alacritty configuration
curl https://github.com/kaveen-lakmuthu/KAlacritty/blob/main/alacritty.toml > $home_dir/.config/alacritty/alacritty.toml || {
    echo "Failed to copy the alacritty configuration file. Exiting."
    exit 1
}

# Copy zsh configuration
curl https://github.com/kaveen-lakmuthu/k-zsh/blob/main/.zshenv > $home_dir/.zshenv || {
    echo "Failed to copy the zsh configuration file. Exiting."
    exit 1
}
curl https://github.com/kaveen-lakmuthu/k-zsh/tree/main/zsh > $home_dir/.config/zsh || {
    echo "Failed to copy the zsh configuration file. Exiting."
    exit 1
}

# Installing starship prompt
curl -sS https://starship.rs/install.sh | sh

starship preset bracketed-segments -o ~/.config/starship.toml
starship preset nerd-font-symbols -o ~/.config/starship.toml

# Installing Pfetch
cd $home_dir/Downloads
wget https://github.com/dylanaraps/pfetch/archive/master.zip
unzip master.zip
install pfetch-master/pfetch /usr/local/bin/
ls -l /usr/local/bin/pfetch
rm -rf pfetch-master master.zip

cd $home_dir

# Set the default wallpaper
nitrogen --set-auto /usr/share/backgrounds/archlinux/

# Make autostart file executable
chmod +x $home_dir/.config/qtile/autostart_once.sh

# make the qtile config file executable
chmod +x $home_dir/.config/qtile/config.py

# put the qtile on .xinitrc
echo "exec qtile start" > $home_dir/.xinitrc

# Enable lightdm service
sudo systemctl enable lightdm.service

# Print success message
echo "Qtile config installed successfully!"

