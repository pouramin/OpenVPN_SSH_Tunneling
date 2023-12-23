#!/bin/bash

# Update package index
sudo apt-get update

# Install required packages
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repository to APT sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index with Docker repository
sudo apt-get update

# Install Docker and Docker Compose plugins
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose

# Print version information
echo "Docker version: $(docker --version)"
echo "Docker Compose version: $(docker-compose --version)"

echo "-------------------------------------------"
echo "Dᴏᴄᴋᴇʀ & ᴅᴏᴄᴋᴇʀ-ᴄᴏᴍᴘᴏsᴇ ʜᴀs ʙᴇᴇɴ ɪɴsᴛᴀʟʟᴇᴅ!"
echo "-------------------------------------------"

echo "youtube.com/@viradesigner"
