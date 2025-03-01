# Use an official Ubuntu base image
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    tor \
    torsocks \
    curl \
    python3

# Copy your tor configuration and startup script into the container
WORKDIR /app
COPY torrc ./torrc
COPY start.sh ./start.sh
RUN chmod +x start.sh

# Expose the port required by Render (render sets PORT env variable)
EXPOSE ${PORT}

# Run your startup script
CMD ["bash", "start.sh"]
