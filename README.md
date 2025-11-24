# Pirtolx API

![CI/CD Status](https://github.com/dorosario1/pirtolx-api/actions/workflows/cicd.yml/badge.svg)
![CI Status](https://github.com/dorosario1/pirtolx-api/actions/workflows/ci.yml/badge.svg)
![Docker Image Version](https://img.shields.io/docker/v/milodorosario/pirtolx-api?sort=semver)

API backend for PirtolX project with AI capabilities and CI/CD automation.

## Features
- FastAPI backend
- AI caching layer (Redis optional)
- Automated CI/CD with GitHub Actions
- Docker production image
- Nginx reverse proxy + SSL
- Robust healthcheck endpoint

## Development
```bash
docker-compose up --build

