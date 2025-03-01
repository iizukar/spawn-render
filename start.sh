#!/bin/bash
set -e

# Download the latest CLI binary if it doesn't exist
if [ ! -f pawns-cli ]; then
  echo "Downloading pawns-cli..."
  curl -L "https://cdn.pawns.app/download/cli/latest/linux_x86_64/pawns-cli" -o pawns-cli
  chmod +x pawns-cli
fi

# Run the CLI with parameters provided via environment variables
./pawns-cli -email="${PAWNS_EMAIL}" -password="${PAWNS_PASSWORD}" -device-name="${PAWNS_DEVICE_NAME}" -accept-tos
