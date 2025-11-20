import asyncio
from fastapi import FastAPI
from src.ai.cache import init_redis, cached
from prometheus_fastapi_instrumentator import Instrumentator

try:
    from prometheus_fastapi_instrumentator import Instrumentator
except Exception:
    Instrumentator = None

app = FastAPI(title="Pirtolx API (FastAPI placeholder)")
Instrumentator().instrument(app).expose(app)

# -----------------------------
# PROMETHEUS METRICS (apply early!)
# -----------------------------
if Instrumentator is not None:
    instrumentator = Instrumentator()
    instrumentator.instrument(app).expose(app, endpoint="/metrics")
else:
    print("prometheus_fastapi_instrumentator not installed; /metrics not exposed")

# -----------------------------
# STARTUP EVENT (Redis init)
# -----------------------------
@app.on_event("startup")
async def startup_event():
    try:
        await init_redis(app)
    except Exception as e:
        print("Redis init warning:", e)

# -----------------------------
# ENDPOINTS
# -----------------------------
@app.get("/api/dropship/items")
@cached("dropship_items", ttl=60)
async def get_dropship_items():
    items = [
        {"id": 1, "title": "Product A", "price": 9.99},
        {"id": 2, "title": "Product B", "price": 19.99},
    ]
    return {"ok": True, "items": items}

@app.get("/health")
async def health():
    return "ok"
