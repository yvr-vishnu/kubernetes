#!/bin/bash

set -e

GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to install Docker
install_docker() {
  echo "Removing old Docker packages..."
  for pkg in docker.io docker-compose docker-compose-v2 podman-docker containerd runc; do
    if sudo apt-get remove -y $pkg; then
      echo "Removed $pkg"
    else
      echo "Package $pkg is not installed, skipping..."
    fi
  done

  echo "Adding Docker's official GPG key..."
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo "Adding Docker repository to Apt sources..."
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  echo "Installing Docker..."
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "Validating Docker installation..."
  sudo docker run hello-world

  echo "Adding current user to Docker group..."
  sudo usermod -aG docker ${USER}
  echo -e "${GREEN}Docker installation completed successfully.${NC}"
  echo "Please log out and log back in to apply Docker group changes, then run the second script to continue the installation."
}

# Main script execution
echo "Starting installation of Docker..."
install_docker