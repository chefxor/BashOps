#!/bin/bash
# Author - Chef
# Github - https://github.com/chefxor

echo "Select your Linux distribution:"
select distro in "Arch Linux" "Fedora"; do
    case $distro in
        "Arch Linux")
            echo "Installing NVIDIA drivers on Arch Linux..."
            pacman -Syu --noconfirm
            pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
            grub_cfg="/boot/grub/grub.cfg"
            grub_default="/etc/default/grub"
            break
            ;;
        "Fedora")
            echo "Installing NVIDIA drivers on Fedora..."
            dnf update -y
            dnf install -y fedora-workstation-repositories
            dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
            dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
            grub_cfg="/boot/efi/EFI/fedora/grub.cfg"
            grub_default="/etc/default/grub"
            break
            ;;
        *)
            echo "Invalid option. Please choose 1 or 2."
            ;;
    esac
done

echo "Are you planning to use Wayland? (y/n)"
read -r wayland
if [[ "$wayland" =~ ^[Yy]$ ]]; then
    echo "Configuring nvidia_drm.modeset=1 for Wayland support..."
    if grep -q "nvidia_drm.modeset=1" "$grub_default"; then
        echo "KMS already set."
    else
        sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="nvidia_drm.modeset=1 /' "$grub_default"
        echo "Updating GRUB configuration..."
        if [[ "$distro" == "Arch Linux" ]]; then
            grub-mkconfig -o "$grub_cfg"
        else
            grub2-mkconfig -o "$grub_cfg"
        fi
    fi
fi

echo "Done. Reboot your system for the changes to take effect."
