# Stage 1: Create environment with shell and netcat
FROM alpine:3.18 as builder

RUN apk add --no-cache \
    netcat-openbsd \
    busybox

# Stage 2: Main application image
FROM iproyal/pawns-cli:latest

# Copy essential components from builder
COPY --from=builder /bin/sh /bin/sh
COPY --from=builder /usr/bin/nc /usr/bin/nc
COPY --from=builder /bin/busybox /bin/busybox

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
