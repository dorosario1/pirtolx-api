# Multi-stage optimized Dockerfile for Pirtolx API
FROM python:3.10-slim AS build

ENV PYTHONDONTWRITEBYTECODE=1             PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN apt-get update && apt-get install -y --no-install-recommends gcc curl             && pip install --no-cache-dir -r requirements.txt             && apt-get remove -y gcc             && apt-get autoremove -y             && rm -rf /var/lib/apt/lists/*

COPY . .

FROM python:3.10-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1             PYTHONUNBUFFERED=1

WORKDIR /app

# copy installed packages and app
COPY --from=build /usr/local/lib/python3.10 /usr/local/lib/python3.10
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /app /app

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --retries=3             CMD curl -f http://localhost:8000/health || exit 1

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
