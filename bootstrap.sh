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

# Symlink dotfiles to home directory
echo "Symlinking dotfiles..."
for file in .zshrc .gitconfig; do
  if [ -e ~/$file ]; then
    echo "Backing up existing file: $file"
    mv ~/$file ~/$file.bak
  fi
  ln -sf ~/.dotfiles/$file ~/$file
done

if [ ! -d "$HOME/.config" ]; then
  echo "Creating .config directory..."
  mkdir ~/.config
fi

if [ -e ~/.config/nvim ]; then
  echo "Backing up existing directory: .config/nvim"
  mv ~/.config/nvim ~/.config/nvim.bak
fi
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim

# Source the new .zshrc to apply changes
echo "Sourcing .zshrc..."
zsh -c "source ~/.zshrc"

echo "Bootstrap completed!"
