# Pirtolx Deploy Bundle

This bundle contains recommended production-ready files for Pirtolx API:
- Optimized Dockerfile (multi-stage)
- requirements.txt (with redis)
- docker-compose.prod.yml (api + redis)
- GitHub Actions workflow to build/push images and deploy to VPS
- FastAPI minimal app with /health endpoint
- Simple redis async cache module
- bootstrap.sh to prepare VPS and start services

**How to use**
1. Place these files at the root of your backend repository.
2. Ensure GitHub secrets are configured: DOCKERHUB_USERNAME, DOCKERHUB_TOKEN, VPS_HOST, VPS_SSH_KEY.
3. Commit & push to master → CI will build and push images, then deploy.
4. On the VPS, run `sudo bash bootstrap.sh` to initialize.

**Notes**
- Replace placeholders and adapt code to your real project structure.
- This bundle intentionally doesn't include secrets.
