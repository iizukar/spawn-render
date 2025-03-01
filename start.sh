#!/bin/bash
set -e

echo "Starting Tor..."
tor -f ./torrc &
sleep 15

if [ ! -f pawns-cli ]; then
  echo "Downloading Pawn CLI..."
  curl -L "https://cdn.pawns.app/download/cli/latest/linux_x86_64/pawns-cli" -o pawns-cli
  chmod +x pawns-cli
fi

echo "Starting Pawn CLI through torsocks..."
torsocks ./pawns-cli -email="${PAWNS_EMAIL}" -password="${PAWNS_PASSWORD}" -device-name="${PAWNS_DEVICE_NAME}" -accept-tos &

echo "Starting dummy HTTP server on port ${PORT}..."
python3 -m http.server ${PORT}
