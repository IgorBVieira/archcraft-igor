#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

echo "Installing Chaotic AUR..."

# Retrieve and sign the key
echo "Retrieving and signing key..."
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB

# Install chaotic-keyring and chaotic-mirrorlist
echo "Installing chaotic-keyring and chaotic-mirrorlist..."
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm

# Add repository to pacman.conf
echo "Adding Chaotic-AUR repository to pacman.conf..."
echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

# Update system
echo "Updating system..."
pacman -Syu --noconfirm

echo "Chaotic AUR has been successfully installed! 🚀"
