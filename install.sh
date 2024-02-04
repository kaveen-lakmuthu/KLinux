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
    lightdm
    thunar
    neofetch
    htop
    dmenu
    unzip
    wget
    vim
)

# Set the GitHub repository URL
REPO_URL="https://github.com/kaveen-lakmuthu/qtile.git"

# Set the destination directory for your Qtile config
DEST_DIR="$HOME/.config/qtile"

echo "Installing dependencies..."

# Install dependencies using the package manager (assuming pacman is used on Arch Linux)
sudo pacman -Syu --needed "${PACKAGES[@]}" || {
    echo "Failed to install dependencies. Exiting."
    exit 1
}

echo "Installing Qtile config from GitHub..."

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git and run the script again."
    exit 1
fi

# Clone the GitHub repository
git clone "$REPO_URL" "$DEST_DIR" || {
    echo "Failed to clone the repository. Exiting."
    exit 1
}

# Make autostart file executable
chmod +x "$DEST_DIR"/autostart_once.sh

# Enable lightdm service
sudo systemctl enable lightdm.service

# Print success message
echo "Qtile config installed successfully!"

