FROM iproyal/pawns-cli:latest
CMD [ "-email=$EMAIL", "-password=$PASSWORD", "-device-name=$DEVICE_NAME", "-device-id=$DEVICE_ID", "-accept-tos" ]
