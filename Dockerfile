# Use an official Ubuntu base image
FROM ubuntu:22.04

# Install necessary packages (tor, torsocks, curl, python3, openssl, netcat)
RUN apt-get update && apt-get install -y \
    tor \
    torsocks \
    curl \
    python3 \
    openssl \
    netcat && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the startup script into the container
COPY start.sh .
RUN chmod +x start.sh

# No need to copy torrc; it will be generated automatically

# Expose the port (Render sets PORT automatically)
EXPOSE 8000

# Start the service by running the startup script
CMD ["bash", "start.sh"]
