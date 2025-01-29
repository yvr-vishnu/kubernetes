#!/bin/bash

set -e

GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to install kubectl
install_kubectl() {
  echo "Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm kubectl

  echo "Validating kubectl installation..."
  kubectl version --client
  echo -e "${GREEN}kubectl installation completed successfully.${NC}"
}

# Function to install Minikube
install_minikube() {
  echo "Installing Minikube..."
  curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64

  echo "Starting Minikube..."
  minikube start
  echo -e "${GREEN}Minikube installation completed successfully.${NC}"
}

# Main script execution
echo "Starting installation of kubectl and Minikube..."
install_kubectl
install_minikube

echo "Querying versions to confirm installations..."
docker --version
kubectl version --client
minikube version

echo -e "${GREEN}Installation of kubectl and Minikube completed successfully.${NC}"