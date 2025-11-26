#!/usr/bin/env bash
set -euo pipefail

SECRET="PIRTOLX_WEBHOOK_2024"
COMPOSE="/srv/pirtolx-api/docker-compose.prod.yml"
PROJECT_DIR="/srv/pirtolx-api"

signature_header=""

while IFS= read -r line; do
  [ "$line" = "" ] && break
  case "$line" in
    X-Hub-Signature-256:*)
        signature_header=$(echo "$line" | cut -d ' ' -f2 | tr -d $'\r')
        ;;
  esac
done

payload=$(cat)

if [[ -z "$signature_header" ]]; then
  echo "Missing signature"
  exit 1
fi

expected="sha256=$(echo -n "$payload" | openssl dgst -sha256 -hmac "$SECRET" | sed 's/^.* //')"

if [[ "$expected" != "$signature_header" ]]; then
  echo "INVALID SIGNATURE"
  exit 1
fi

echo "[Webhook] Signature OK."

cd "$PROJECT_DIR"

echo "[Webhook] Pulling new image..."
docker pull milodorosario/pirtolx-api:latest

echo "[Webhook] Restarting container..."
docker compose -f "$COMPOSE" down
docker compose -f "$COMPOSE" up -d --force-recreate

echo "[Webhook] DONE"
