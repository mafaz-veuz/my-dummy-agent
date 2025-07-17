#!/bin/bash

echo "Installing Dummy Agent..."

# ✅ Expect organizationId from the environment
if [ -z "$organizationId" ]; then
    echo "❌ Error: organizationId is not set."
    exit 1
fi

# Create target directory
sudo mkdir -p /usr/lib/DummyAgent

# Download and install binary (or copy from current if local)
curl -fsSL "$base/DummyAgent" -o /tmp/DummyAgent
sudo mv /tmp/DummyAgent /usr/lib/DummyAgent/DummyAgent
sudo chmod +x /usr/lib/DummyAgent/DummyAgent

# Create config.json with organizationId
echo "{ \"organizationId\": \"$organizationId\" }" | sudo tee /usr/lib/DummyAgent/config.json > /dev/null
sudo chmod 644 /usr/lib/DummyAgent/config.json

# Download and install service file
curl -fsSL "$base/dummyagent.service" -o /tmp/dummyagent.service
sudo mv /tmp/dummyagent.service /lib/systemd/system/dummyagent.service
sudo chmod 644 /lib/systemd/system/dummyagent.service

# Start service
sudo systemctl daemon-reload
sudo systemctl enable dummyagent.service
sudo systemctl start dummyagent.service

echo "✅ Dummy Agent installed and running with Org ID: $organizationId"
