# Stage 1: Get static busybox
FROM busybox:1.36 as bb

# Stage 2: Main application
FROM iproyal/pawns-cli:latest

# Copy busybox to dedicated directory
COPY --from=bb /bin/busybox /bb/busybox

# Verify binary exists and permissions
RUN ["/bb/busybox", "mkdir", "-p", "/bin"]

# Install applets carefully
RUN ["/bb/busybox", "--install", "-s", "/bin"]

# Copy start script and set permissions
COPY start.sh /start.sh
RUN ["/bin/chmod", "+x", "/start.sh"]

CMD ["/start.sh"]
