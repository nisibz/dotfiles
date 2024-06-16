#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

# Install zsh
echo "installing zsh"
sudo apt install zsh

# Symlink dotfiles to home directory
echo "Symlinking dotfiles..."
ln -sf ~/.dotfiles/.zshrc ~/.zshrc

# Change default shell to zsh
chsh -s "$(command -v zsh)"

# Source the new .zshrc to apply changes
echo "Sourcing .zshrc..."
source ~/.zshrc

echo "Bootstrap completed!"
