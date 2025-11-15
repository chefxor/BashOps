#!/bin/bash

# Function to display messages
echo_info() {
    echo -e "\e[1;34m[INFO]\e[0m $1"
}
echo_success() {
    echo -e "\e[1;32m[SUCCESS]\e[0m $1"
}
echo_error() {
    echo -e "\e[1;31m[ERROR]\e[0m $1"
}

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo_error "This installer must be run as root! Use sudo." >&2
    exit 1
fi

# Update system
echo_info "Updating system packages..."
pacman -Syu --noconfirm

# Install required packages
echo_info "Installing QEMU, libvirt, and virt-manager..."
apt install qemu-full libvirt virt-manager -y

# Enable and start libvirt service
echo_info "Enabling and starting libvirtd service..."
systemctl enable --now libvirtd

# Add current user to libvirt group
USER=$(logname)
echo_info "Adding user '$USER' to libvirt group..."
usermod -aG libvirt "$USER"

# Completion message
echo_success "Installation complete! Please reboot your system for changes to take effect."
