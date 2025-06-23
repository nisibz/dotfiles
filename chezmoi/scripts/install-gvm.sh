#!/bin/bash

# Install GVM
if ! command -v gvm &> /dev/null; then
    echo "Installing GVM..."
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    
    if [ -f ~/.gvm/scripts/gvm ]; then
        echo "GVM installed successfully"
    else
        echo "GVM installation failed - scripts not found"
    fi
else
    echo "GVM already installed"
fi