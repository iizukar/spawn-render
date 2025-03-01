#!/bin/sh

# Start health check server
busybox httpd -p $PORT -f -v &

# Run Pawns client
exec pawns-cli \
  -email="$EMAIL" \
  -password="$PASSWORD" \
  -device-name="$DEVICE_NAME" \
  -device-id="$DEVICE_ID" \
  -accept-tos
