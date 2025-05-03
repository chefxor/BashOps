#!/bin/bash
# Author - Chef
# Github - https://github.com/chefxor

echo "Select your Linux distribution:"
select distro in "Arch Linux" "Fedora"; do
    case $distro in
        "Arch Linux")
            echo "Installing NVIDIA drivers on Arch Linux..."
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
            grub_cfg="/boot/grub/grub.cfg"
            grub_default="/etc/default/grub"
            break
            ;;
        "Fedora")
            echo "Installing NVIDIA drivers on Fedora..."
            sudo dnf update -y
            sudo dnf install -y fedora-workstation-repositories
            sudo dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
            sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
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
        sudo sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="nvidia_drm.modeset=1 /' "$grub_default"
        echo "Updating GRUB configuration..."
        if [[ "$distro" == "Arch Linux" ]]; then
            sudo grub-mkconfig -o "$grub_cfg"
        else
            sudo grub2-mkconfig -o "$grub_cfg"
        fi
    fi
fi

echo "Done. Reboot your system for the changes to take effect."
