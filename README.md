# Pirtolx API

![CI/CD Status](https://github.com/dorosario1/pirtolx-api/actions/workflows/cicd.yml/badge.svg)
![CI Status](https://github.com/dorosario1/pirtolx-api/actions/workflows/ci.yml/badge.svg)

API backend for the PirtolX platform with AI processing, caching, and full CI/CD automation.

## Features
- FastAPI backend
- Redis + intelligent caching layer
- Automated CI + CD with GitHub Actions
- Docker containerization
- Production deployment with nginx reverse proxy + SSL
- Healthcheck endpoint for robust orchestration

## Development
Run locally:
```bash
docker-compose up --build

