#!/bin/sh

# Start basic HTTP server for Render health checks
while true; do
  echo -e "HTTP/1.1 200 OK\n\nOK" | nc -l -p $PORT -q 1
done &

# Run Pawns client with environment variables
exec pawns-cli \
  -email="$EMAIL" \
  -password="$PASSWORD" \
  -device-name="$DEVICE_NAME" \
  -device-id="$DEVICE_ID" \
  -accept-tos
