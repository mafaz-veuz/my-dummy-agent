#!/bin/bash
echo "📦 Installing Dummy Agent..."

# Paths
agent_dir="/usr/lib/DummyAgent"
binary_path="$agent_dir/DummyAgent"
service_path="/lib/systemd/system/dummyagent.service"
config_path="$agent_dir/config.json"

# Ensure organizationId is passed
if [ -z "$organizationId" ]; then
    echo "❌ organizationId not provided. Exiting..."
    exit 1
fi

# Download and install files
sudo mkdir -p "$agent_dir"

# Download DummyAgent binary
curl -fsSL "$base/DummyAgent" -o /tmp/DummyAgent
sudo mv /tmp/DummyAgent "$binary_path"
sudo chmod +x "$binary_path"

# Download and install systemd service file
curl -fsSL "$base/dummyagent.service" -o /tmp/dummyagent.service
sudo mv /tmp/dummyagent.service "$service_path"
sudo chmod 644 "$service_path"

# Reload systemd and start service
sudo systemctl daemon-reload
sudo systemctl enable dummyagent.service
sudo systemctl start dummyagent.service

# Create config.json with organizationId
cat <<EOF | sudo tee "$config_path" > /dev/null
{
  "organizationId": "$organizationId"
}
EOF

echo "✅ Dummy Agent installed and running with Org ID: $organizationId"
echo "📄 Config saved at $config_path"
