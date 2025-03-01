#!/bin/bash
set -e

# Install Tor and torsocks (assumes an Ubuntu/Debian environment)
echo "Updating packages and installing Tor and torsocks..."
apt-get update && apt-get install -y tor torsocks

# Start the Tor service (using systemctl or service as appropriate)
echo "Starting Tor service..."
systemctl start tor || service tor start

# Wait for Tor to initialize (adjust sleep time if needed)
echo "Waiting for Tor to fully start..."
sleep 15

# Download the Pawn CLI binary if not already present
if [ ! -f pawns-cli ]; then
  echo "Downloading Pawn CLI..."
  curl -L "https://cdn.pawns.app/download/cli/latest/linux_x86_64/pawns-cli" -o pawns-cli
  chmod +x pawns-cli
fi

# Run the Pawn CLI via torsocks so that all its TCP connections (and DNS lookups) are routed through Tor
echo "Starting Pawn CLI through Tor..."
torsocks ./pawns-cli -email="${PAWNS_EMAIL}" -password="${PAWNS_PASSWORD}" -device-name="${PAWNS_DEVICE_NAME}" -accept-tos &

# Start a simple dummy HTTP server on Render’s required port ($PORT)
echo "Starting dummy HTTP server on port ${PORT}..."
python3 -m http.server ${PORT}
