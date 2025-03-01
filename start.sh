#!/bin/bash
set -e

# -----------------------------
# Step 1: Auto-generate torrc if missing
# -----------------------------
if [ ! -f ./torrc ]; then
  # Generate a random control password using OpenSSL
  CONTROL_PASSWORD=$(openssl rand -hex 16)
  echo "Generated control password: $CONTROL_PASSWORD" >&2

  # Generate the hashed password using Tor's built-in tool.
  # (This outputs several lines; we take the last one which contains the hash.)
  HASHED=$(tor --hash-password "$CONTROL_PASSWORD" | tail -n1)

  # Create torrc with the required settings:
  cat <<EOF > torrc
SocksPort 9050
ControlPort 9051
CookieAuthentication 0
HashedControlPassword $HASHED
MaxCircuitDirtiness 60
Log notice stdout
EOF
  echo "torrc generated."
fi

# -----------------------------
# Step 2: Start Tor using our generated torrc
# -----------------------------
echo "Starting Tor..."
tor -f ./torrc &
TOR_PID=$!
echo "Tor started with PID $TOR_PID"

# Allow time for Tor to establish its circuits
echo "Waiting for Tor circuits to establish..."
sleep 15

# -----------------------------
# Step 3: Download Pawn CLI if not already present
# -----------------------------
if [ ! -f pawns-cli ]; then
  echo "Downloading Pawn CLI..."
  curl -L "https://cdn.pawns.app/download/cli/latest/linux_x86_64/pawns-cli" -o pawns-cli
  chmod +x pawns-cli
fi

# -----------------------------
# Step 4: Start Pawn CLI via torsocks (routing traffic through Tor)
# -----------------------------
echo "Starting Pawn CLI through torsocks..."
torsocks ./pawns-cli \
  -email="${PAWNS_EMAIL}" \
  -password="${PAWNS_PASSWORD}" \
  -device-name="${PAWNS_DEVICE_NAME}" \
  -accept-tos &
PAWN_PID=$!
echo "Pawn CLI started with PID $PAWN_PID"

# (Optional: Insert logic here to monitor logs and, if an error like "non_residential_ip" occurs,
# signal Tor for a new circuit via the control port and restart Pawn CLI.)

# -----------------------------
# Step 5: Start a dummy HTTP server to satisfy Render’s Web Service requirement
# -----------------------------
echo "Starting dummy HTTP server on port ${PORT}..."
python3 -m http.server ${PORT}
