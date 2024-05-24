#!/bin/sh

# This script will setup the environment for this neovim configuration on linux/WSL Linux
echo "Installing environment prerequisites! Please wait..."

# Ensure we have the required buildtools
sudo apt-get install -y build-essential cmake

# Install tools needed for mason
sudo apt-get install -y unzip wget curl gzip tar

# Install nodejs >=v21 and neovim provider
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt-get install -y nodejs
rm nodesource_setup.sh
sudo npm install -g npm
sudo npm install -g neovim

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install golang
wget -q -O - https://git.io/vQhTU | bash

# Install python3
sudo apt-get install -y python3 python3-pip pipenv

# Setup neovim python venv with neovim provider
mkdir -p ~/.nvimenv/.venv
(
	cd ~/.nvimenv/.venv
	pipenv install pynvim
)

# Install terraform and shfmt
sudo apt-get install -y shfmt terraform

# Install dotnet
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update &&
	sudo apt-get install -y dotnet-sdk-8.0

echo "Environment setup complete! Please restart the shell and run neovim!"
