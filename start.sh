#!/bin/sh

# Start health check server using busybox httpd
busybox httpd -p $PORT -f &

# Run Pawns client
exec pawns-cli \
  -email="$EMAIL" \
  -password="$PASSWORD" \
  -device-name="$DEVICE_NAME" \
  -device-id="$DEVICE_ID" \
  -accept-tos
