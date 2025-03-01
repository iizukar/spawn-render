#!/bin/bash
set -e

# Download the latest CLI binary if it isn't already present
if [ ! -f pawns-cli ]; then
  echo "Downloading pawns-cli..."
  curl -L "https://cdn.pawns.app/download/cli/latest/linux_x86_64/pawns-cli" -o pawns-cli
  chmod +x pawns-cli
fi

# Start the Pawn CLI in the background using environment variables for credentials
./pawns-cli -email="${PAWNS_EMAIL}" -password="${PAWNS_PASSWORD}" -device-name="${PAWNS_DEVICE_NAME}" -accept-tos &

# Render Web Services require a process to listen on the assigned port ($PORT).
# Here we launch a simple dummy HTTP server (using Python) to bind to $PORT.
# This dummy server ensures Render’s health checks pass.
echo "Starting dummy HTTP server on port ${PORT}..."
python3 -m http.server ${PORT}
