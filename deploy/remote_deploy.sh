#!/usr/bin/env bash
set -euo pipefail

DEPLOY_DIR="/opt/pirtolx/app"

echo "[>] Deploying Pirtolx API..."

mkdir -p $DEPLOY_DIR
cd $DEPLOY_DIR

echo "[>] Pulling latest images..."
docker compose pull

echo "[>] Starting services..."
docker compose up -d --remove-orphans

echo "[>] Waiting for health..."
timeout=60
until curl -sSf http://127.0.0.1:8000/health >/dev/null 2>&1 || [ $timeout -le 0 ]; do
  sleep 2
  timeout=$((timeout-2))
done

if [ $timeout -le 0 ]; then
  echo "[X] Deployment FAILED (healthcheck timeout)"
  exit 1
fi

echo "[✓] Deployment SUCCESSFUL"
