#!/bin/bash

# Install RVM and Ruby 1.9.3
if ! command -v rvm &> /dev/null; then
    echo "Installing RVM..."
    # Import GPG keys first
    gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB || {
        echo "GPG keyserver failed, importing keys from URLs..."
        curl -sSL https://rvm.io/mpapis.asc | gpg --import -
        curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
    }
    
    # Install RVM
    curl -sSL https://get.rvm.io | bash -s stable
    
    # Source RVM and install Ruby if installation succeeded
    if [ -f ~/.rvm/scripts/rvm ]; then
        source ~/.rvm/scripts/rvm
        rvm install 1.9.3
        rvm use 1.9.3 --default
        echo "RVM and Ruby 1.9.3 installed successfully"
    else
        echo "RVM installation failed - scripts not found"
    fi
else
    echo "RVM already installed, ensuring Ruby 1.9.3 is available..."
    source ~/.rvm/scripts/rvm
    if ! rvm list | grep -q "1.9.3"; then
        rvm install 1.9.3
    fi
    rvm use 1.9.3 --default
fi