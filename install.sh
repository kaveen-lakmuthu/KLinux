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

# Install the required packages
echo "Installing dependencies..."

pacman -Syu --needed "${PACKAGES[@]}" || {
    echo "Failed to install dependencies. Exiting."
    exit 1
}

xdg-user-dirs-update

# Copy the configuration files
echo "Copying configuration files..."
cd $home_dir/Downloads

# cloning qtile config

git clone https://github.com/kaveen-lakmuthu/qtile.git $home_dir/.config/qtile || {
    echo "Failed to copy the configuration file. Exiting."
    exit 1
}

# Copy picom configuration
git clone https://github.com/kaveen-lakmuthu/k-picomgit || {
    echo "Failed to copy the picom configuration file. Exiting."
    exit 1
}

# Copy alacritty configuration
git clone https://github.com/kaveen-lakmuthu/KAlacritty.git || {
    echo "Failed to copy the alacritty configuration file. Exiting."
    exit 1
}

# Copy zsh configuration
git clone https://github.com/kaveen-lakmuthu/k-zsh.git || {
    echo "Failed to copy the zsh configuration file. Exiting."
    exit 1
}

mv k-picom/picom.conf $home_dir/.config/picom/picom.conf
mv KAlacritty/alacritty.toml $home_dir/.config/alacritty/alacritty.toml
mv k-zsh/.zshenv $home_dir/.zshenv
mv k-zsh/zsh $home_dir/.config/zsh
rm -rf k-picom KAlacritty k-zsh


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

