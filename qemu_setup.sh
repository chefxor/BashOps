#!/bin/bash

# Update the system first
sudo pacman -Syu

# Install the fulll QEMU package
sudo pacman -S qemu-full

# Install libvirt and virt-manager (GUI)
sudo pacman -S libvirt virt-manager

# Enable and start the libvirt service
sudo systemctl enable --now libvirtd

# Add your user to the libvirt group (required for non-root access)
sudo usermod -aG libvirt $(whoami)

echo "[+] Installation complete. Please perform a system reboot!"
