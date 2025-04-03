#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Installing UFW (Uncomplicated Firewall)..."
pacman -S ufw

echo "Configuring firewall rules..."
ufw default deny incoming
ufw default allow outgoing
ufw allow OpenSSH
ufw allow 80/tcp   # Allow HTTP (optional)
ufw allow 443/tcp  # Allow HTTPS (optional)

echo "Enabling logging..."
ufw logging on

echo "Enabling UFW..."
ufw --force enable

echo "Firewall is now active and secured!"
ufw status verbose
