#!/bin/sh
# Start Honeygain
./pawns-cli \
  -email="$PAWNS_EMAIL" \
  -password="$PAWNS_PASSWORD" \
  -device-name="$PAWNS_DEVICE_NAME" \
  -device-id="$PAWNS_DEVICE_ID" \
  -accept-tos &

# Start dummy HTTP server on port 8000
python3 -m http.server 8000 --bind 0.0.0.0 &

# Keep the container alive
tail -f /dev/null
