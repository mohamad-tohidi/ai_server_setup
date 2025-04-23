#!/bin/bash
set -e

# Show commands as they execute (optional)
# set -x

echo "🚀 Starting NATS setup..."

# 1. Create data directory
echo "📁 Creating data directory at /nats-data..."
sudo mkdir -p /nats-data

# 2. Write NATS configuration with max_payload = 8MB
echo "📝 Writing nats-server.conf (max_payload=8MB)..."
sudo tee /nats-data/nats-server.conf > /dev/null << 'EOF'
# NATS Server Configuration

# Maximum payload size per message
max_payload: 8MB

EOF

# 3. Pull the NATS Docker image
echo "⬇️ Pulling NATS image from docker.arvancloud.ir..."
sudo docker pull docker.arvancloud.ir/nats

# 4. Run the NATS container with restart policy, ports, and volumes
echo "▶️ Starting NATS container..."
sudo docker run --restart=always -d \
  -p 4222:4222 \
  -p 8222:8222 \
  -v /nats-data/nats-server.conf:/etc/nats/nats-server.conf:ro \
  -v /nats-data:/nats-data \
  docker.arvancloud.ir/nats \
  -js \
  -sd /nats-data \
  -c /etc/nats/nats-server.conf

# 5. Verify it's running
echo "🔍 Verifying container is up..."
sudo docker ps --filter "ancestor=docker.arvancloud.ir/nats" --format "table {{.Names}}\t{{.Status}}"

echo "✅ NATS has been set up and is running with max_payload = 8MB!"

