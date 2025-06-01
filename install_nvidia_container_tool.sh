#!/bin/bash

set -e

echo "[INFO] Installing NVIDIA Container Toolkit (latest method)..."

# Step 1: Add GPG key and repository
echo "[INFO] Adding NVIDIA GPG key and repository..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
  sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

# (Optional) Enable experimental packages
echo "[INFO] Enabling experimental packages (optional)..."
sudo sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list || true

# Step 2: Update packages and install the toolkit
echo "[INFO] Updating package list..."
sudo apt-get update

echo "[INFO] Installing NVIDIA container toolkit and config utility..."
sudo apt-get install -y nvidia-container-toolkit

# Step 3: Configure Docker to use NVIDIA runtime
echo "[INFO] Configuring Docker to use the NVIDIA runtime..."
sudo nvidia-ctk runtime configure --runtime=docker

# Step 4: Restart Docker
echo "[INFO] Restarting Docker..."
sudo systemctl restart docker

# Step 5: Verify setup
echo "[INFO] Installation complete. To test, run:"
echo "  sudo docker run --rm --gpus all nvidia/cuda:12.3.2-base-ubuntu22.04 nvidia-smi"

