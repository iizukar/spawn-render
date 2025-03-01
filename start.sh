#!/bin/bash
set -e

echo "Starting Tor..."
# Run Tor with our custom torrc (make sure torrc is in your repository)
./tor -f ./torrc &
TOR_PID=$!
echo "Tor started with PID $TOR_PID"

# Wait for Tor to establish its circuits (adjust sleep time if needed)
sleep 15

# Download Pawn CLI binary if it doesn't exist
if [ ! -f pawns-cli ]; then
  echo "Downloading Pawn CLI..."
  curl -L "https://cdn.pawns.app/download/cli/latest/linux_x86_64/pawns-cli" -o pawns-cli
  chmod +x pawns-cli
fi

echo "Starting Pawn CLI through torsocks..."
# Run Pawn CLI wrapped with torsocks to force its TCP/DNS through Tor
torsocks ./pawns-cli -email="${PAWNS_EMAIL}" -password="${PAWNS_PASSWORD}" -device-name="${PAWNS_DEVICE_NAME}" -accept-tos &

echo "Starting dummy HTTP server on port ${PORT}..."
# Start a simple Python HTTP server to satisfy Render's health checks
python3 -m http.server ${PORT}
