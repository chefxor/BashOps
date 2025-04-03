#!/bin/bash

# Author - Chef
# Github - https://github.com/chefxor

# Initial update & upgrade
pacman -Syyu

# Installation of yay AUR handler
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Installation of neccessary packages
pacman -S alacritty awesome rofi picom network-manager-applet ufw zsh neovim tmux kitty emacs fish stow xorg-xinit xclip flameshot tree lf nitrogen lxappearance pcmanfm ripgrep pass terminator rofi ripgrep
# Installing fonts
yay -S ttf-hack-nerd ttf-firacode-nerd ttf-iosevkaterm-nerd ttf-mononoki-nerd ttf-terminus-nerd

# Setting up neovim
sh ~/BashOps/nvim_setup.sh

# Setting up firwall
sh ~/BashOps/firewall_setup.sh
