#!/bin/bash
set -e

echo "Installing Docker and Git..."
apt-get update -y
apt-get install -y git docker.io

echo "Enabling and starting Docker..."
systemctl enable --now docker

echo "Cloning website repository..."
rm -rf /opt/site
git clone ${github_repo_url} /opt/site

echo "Building the static website image..."
cd /opt/site/static-website
docker build -t static-website .

echo "Running the container on port 8085..."
docker rm -f static-website 2>/dev/null || true
docker run -d --name static-website --restart unless-stopped -p 8085:8085 static-website

echo "Static website deployment completed successfully."
