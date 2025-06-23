#!/bin/bash

# Install NVM and Node.js 20.11.1
if ! command -v nvm &> /dev/null; then
    echo "Installing NVM..."
    # Install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    
    # Source NVM and install Node.js if installation succeeded
    if [ -f ~/.nvm/nvm.sh ]; then
        source ~/.nvm/nvm.sh
        nvm install 20.11.1
        nvm use 20.11.1
        nvm alias default 20.11.1
        echo "NVM and Node.js 20.11.1 installed successfully"
    else
        echo "NVM installation failed - scripts not found"
    fi
else
    echo "NVM already installed, ensuring Node.js 20.11.1 is available..."
    source ~/.nvm/nvm.sh 2>/dev/null || source /usr/share/nvm/nvm.sh
    if ! nvm list | grep -q "20.11.1"; then
        nvm install 20.11.1
    fi
    nvm use 20.11.1
    nvm alias default 20.11.1
fi