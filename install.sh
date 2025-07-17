#!/bin/bash

echo "Installing Dummy Agent..."

# Update this link to match your GitHub username and repo
DEB_URL="https://raw.githubusercontent.com/mafaz-veuz/my-dummy-agent/main/dummyagent_1.0_all.deb"
DEB_FILE="/tmp/dummyagent.deb"

# Download .deb file
echo "Downloading dummyagent package..."
curl -L --progress-bar "$DEB_URL" -o "$DEB_FILE"

# Install it
echo "Installing package..."
sudo dpkg -i "$DEB_FILE"

# Fix any dependencies
sudo apt-get install -f -y

# Enable and start the service
echo "Enabling and starting dummyagent service..."
sudo systemctl daemon-reload
sudo systemctl enable dummyagent.service
sudo systemctl start dummyagent.service

echo "✅ Dummy Agent installed and running!"

