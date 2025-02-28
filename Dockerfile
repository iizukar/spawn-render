FROM iproyal/pawns-cli:latest
CMD [ "-email=$EMAIL", "-password=$PASSWORD", "-device-name=raspberrypi", "-device-id=raspberrypi1", "-accept-tos" ]
