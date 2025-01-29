#!/bin/bash

set -e

# Function to remove Minikube
remove_minikube() {
  echo "Stopping Minikube..."
  minikube stop || true
  echo "Deleting Minikube..."
  minikube delete || true
  echo "Removing Minikube binary..."
  sudo rm -f /usr/local/bin/minikube
  echo "Minikube removed successfully."
}

# Function to remove kubectl
remove_kubectl() {
  echo "Removing kubectl binary..."
  sudo rm -f /usr/local/bin/kubectl
  echo "kubectl removed successfully."
}

# Function to remove Docker
remove_docker() {
  echo "Stopping Docker service..."
  sudo systemctl stop docker || true
  echo "Removing Docker packages..."
  sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  echo "Removing Docker group..."
  sudo groupdel docker || true
  echo "Removing Docker directories..."
  sudo rm -rf /var/lib/docker
  sudo rm -rf /var/lib/containerd
  echo "Docker removed successfully."
}

# Function to remove user from Docker group
remove_user_from_docker_group() {
  echo "Removing user from Docker group..."
  sudo gpasswd -d ${USER} docker || true
  echo "User removed from Docker group successfully."
}

# Main script execution
echo "Starting removal of Minikube, kubectl, and Docker..."
remove_minikube
remove_kubectl
remove_docker
remove_user_from_docker_group
echo "Removal of Minikube, kubectl, and Docker completed successfully."