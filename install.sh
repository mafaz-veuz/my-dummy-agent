#!/bin/bash
echo "Installing Dummy Agent..."

# Copy binary and service file
sudo mkdir -p /usr/lib/DummyAgent
sudo cp DummyAgent /usr/lib/DummyAgent/
sudo chmod +x /usr/lib/DummyAgent/DummyAgent

sudo cp dummyagent.service /lib/systemd/system/
sudo chmod 644 /lib/systemd/system/dummyagent.service

# Enable + Start
sudo systemctl daemon-reload
sudo systemctl enable dummyagent.service
sudo systemctl start dummyagent.service

echo "Dummy Agent Installed & Running."
