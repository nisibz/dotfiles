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

# Function to check if a plugin is already installed
zsh_plugin_exists() {
    local plugin_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$1"
    [ -d "$plugin_path" ]
}

# Install Oh My Zsh plugins
echo "Installing Oh My Zsh plugins..."

# Install zsh-autosuggestions if not already installed
if zsh_plugin_exists "zsh-autosuggestions"; then
    echo "zsh-autosuggestions is already installed"
else
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting if not already installed
if zsh_plugin_exists "zsh-syntax-highlighting"; then
    echo "zsh-syntax-highlighting is already installed"
else
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install you-should-use if not already installed
if zsh_plugin_exists "you-should-use"; then
    echo "you-should-use is already installed"
else
    echo "Installing you-should-use..."
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use
fi

# Install zsh-bat if not already installed
if zsh_plugin_exists "zsh-bat"; then
    echo "zsh-bat is already installed"
else
    echo "Installing zsh-bat..."
    git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat
fi


# Symlink dotfiles to home directory
echo "Symlinking dotfiles..."
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
if [ ! -d "$HOME/.config" ]; then
    echo "Creating .config directory..."
    mkdir ~/.config
fi
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim

# Install neovim if not already installed
if command_exists nvim; then
    echo "neovim is already installed"
else
    echo "Installing neovim..."
    sudo apt install -y neovim
fi

# Source the new .zshrc to apply changes
echo "Sourcing .zshrc..."
zsh -c "source ~/.zshrc"

echo "Bootstrap completed!"

