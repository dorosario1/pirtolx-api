# Pirtolx API

![CI/CD Status](https://github.com/dorosario1/pirtolx-api/actions/workflows/cicd.yml/badge.svg)
![CI Status](https://github.com/dorosario1/pirtolx-api/actions/workflows/ci.yml/badge.svg)
![Docker Image Version](https://img.shields.io/docker/v/milodorosario/pirtolx-api?sort=semver)
![FastAPI](https://img.shields.io/badge/FastAPI-0.104.1-009688?logo=fastapi)

API backend for the PirtolX platform with AI capabilities and automated CI/CD pipeline.

## Features
- FastAPI backend
- AI caching layer (Redis optional)
- Automated CI/CD with GitHub Actions
- Docker production image
- Nginx reverse proxy + SSL
- Robust healthcheck endpoint

## Development
To run locally:
\`\`\`bash
docker-compose up --build
\`\`\`

## Production
Production deployment is automated through GitHub Actions CI/CD.
