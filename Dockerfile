# Stage 1: Use official busybox image
FROM busybox:1.36 as builder

# Stage 2: Main application image
FROM iproyal/pawns-cli:latest

# Copy static busybox binary
COPY --from=builder /bin/busybox /busybox

# Create essential directories and install applets
RUN ["/busybox", "mkdir", "-p", "/bin"] && \
    ["/busybox", "--install", "-s"]

# Copy start script and set permissions
COPY start.sh /start.sh
RUN ["/busybox", "chmod", "+x", "/start.sh"]

CMD ["/start.sh"]
