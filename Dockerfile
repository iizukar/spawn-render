FROM iproyal/pawns-cli:latest
CMD [ "-email=$EMAIL", "-password=$PASSWORD", "-device-name=$DEVICE_NAME", "-accept-tos" ]
