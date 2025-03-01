# Use the Pawn CLI image as the base
FROM iproyal/pawns-cli:latest

# (Optional) Expose any ports if your application requires it

# Set the default command with arguments. It’s best to parameterize sensitive values.
CMD [ "-email=${PAWNS_EMAIL}", "-password=${PAWNS_PASSWORD}", "-device-name=${PAWNS_DEVICE_NAME}", "-device-id=${PAWNS_DEVICE_ID}", "-accept-tos" ]
