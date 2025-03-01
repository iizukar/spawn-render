FROM iproyal/pawns-cli:latest

# Install netcat for health checks
RUN apk add --no-cache netcat-openbsd

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
