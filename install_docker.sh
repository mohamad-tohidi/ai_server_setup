#!/bin/bash

set -e

echo "🚀 Starting Docker installation..."
sleep 1

echo "📦 Updating package information..."
sudo apt-get update -y
sleep 1

echo "🔧 Installing prerequisite packages..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sleep 1

echo "🔐 Adding Docker’s official GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sleep 1

echo "🗂️ Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 1

echo "🔄 Updating package info with Docker repo..."
sudo apt-get update -y
sleep 1

echo "📥 Installing Docker Engine and related packages..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sleep 1

echo "✅ Docker installation complete!"

echo "🔄 Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker
sleep 1

echo "🧪 Verifying Docker installation..."
sudo docker run hello-world

echo "🎉 Docker is installed and running!"

