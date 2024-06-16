#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

# Install zsh
echo "installing zsh"
sudo apt install zsh

# Install oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install oh-my-zsh plugin
echo "Installing oh-my-zsh plugin"
echo "Install zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install brew
echo "Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install Homebrew's dependencies
sudo apt-get install build-essential -y

# Switch shell to zsh
zsh

# Symlink dotfiles to home directory
echo "Symlinking dotfiles..."
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig

# Change default shell to zsh
chsh -s "$(command -v zsh)"

# Source the new .zshrc to apply changes
echo "Sourcing .zshrc..."
source ~/.zshrc

echo "Bootstrap completed!"
