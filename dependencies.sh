#!/bin/bash

# Update package lists
apt-get update

# Install Docker
apt-get install docker.io -y

# Add user to the docker group
usermod -aG docker $USER

# Start a new shell to apply group changes
newgrp docker

# Set permissions for Docker socket
chmod 777 /var/run/docker.sock

# Run SonarQube in Docker
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# Install wget, apt-transport-https, gnupg, and lsb-release
apt-get install wget apt-transport-https gnupg lsb-release -y

# Add Trivy GPG key
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -

# Add Trivy repository
echo "deb https://aquasecurity.github.io/trivy-repo/deb \$(lsb_release -sc) main" | tee -a /etc/apt/sources.list.d/trivy.list

# Update package lists after adding Trivy repository
apt-get update

# Install Trivy
apt-get install trivy -y

