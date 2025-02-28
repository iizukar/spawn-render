FROM iproyal/pawns-cli:latest
CMD [./pawns-cli -email="$EMAIL" -password="$PASSWORD" -device-name=raspberrypi -accept-tos]
