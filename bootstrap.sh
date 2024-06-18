#!/bin/bash

# Function to check if a command exists
command_exists() {
    dpkg -l | grep -qw "$1" || command -v "$1" >/dev/null 2>&1
}

# Install zsh if not already installed
if command_exists zsh; then
    echo "zsh is already installed"
else
    echo "Installing zsh..."
    sudo apt install -y zsh
fi

# Install Oh My Zsh if not already installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed"
else
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Oh My Zsh plugins
echo "Installing Oh My Zsh plugins..."

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install you-should-use
echo "Installing you-should-use..."
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

# Install zsh-bat
echo "Installing zsh-bat..."
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat


# Symlink dotfiles to home directory
echo "Symlinking dotfiles..."
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.config ~/.config

# Change default shell to zsh
if [ "$SHELL" = "$(command -v zsh)" ]; then
    echo "Default shell is already zsh"
else
    echo "Changing default shell to zsh..."
    chsh -s "$(command -v zsh)"
fi

# Source the new .zshrc to apply changes
echo "Sourcing .zshrc..."
zsh -c "source ~/.zshrc"

echo "Bootstrap completed!"

