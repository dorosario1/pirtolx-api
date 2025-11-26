#!/usr/bin/env bash
set -euo pipefail

# Bootstrap script to prepare VPS and run docker compose for Pirtolx
# Usage: sudo bash bootstrap.sh

echo "Creating directories..."
sudo mkdir -p /srv/pirtolx-api
sudo chown ubuntu:ubuntu /srv/pirtolx-api

# If an existing .env exists in /opt/pirtolx/backend, copy it
if [ -f /opt/pirtolx/backend/.env ]; then
  echo "Copying existing .env from /opt/pirtolx/backend"
  sudo cp /opt/pirtolx/backend/.env /srv/pirtolx-api/.env
  sudo chmod 600 /srv/pirtolx-api/.env
else
  echo "No existing .env found at /opt/pirtolx/backend/.env. Please create /srv/pirtolx-api/.env"
fi

echo "Writing docker-compose..."
# If you want to overwrite docker-compose, uncomment next lines or ensure file present
# sudo cp ./docker-compose.prod.yml /srv/pirtolx-api/docker-compose.prod.yml

echo "Pulling latest images and starting services..."
cd /srv/pirtolx-api
sudo docker compose -f docker-compose.prod.yml pull || true
sudo docker compose -f docker-compose.prod.yml up -d --force-recreate

echo "Done. Use 'docker ps' and 'docker logs -f pirtolx-api' to check status."
