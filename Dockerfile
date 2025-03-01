# Stage 1: Prepare utilities
FROM alpine:3.18 as builder

RUN apk add --no-cache \
    netcat-openbsd \
    busybox

# Stage 2: Main application image
FROM iproyal/pawns-cli:latest

# Copy essential components
COPY --from=builder /usr/bin/nc /usr/bin/nc
COPY --from=builder /bin/busybox /bin/busybox

# Create busybox symlinks without shell dependency
RUN ["/bin/busybox", "--install", "-s", "/bin"]

# Copy start script and set permissions directly
COPY start.sh /start.sh
RUN ["chmod", "+x", "/start.sh"]

CMD ["/start.sh"]
