import os
import redis.asyncio as redis

REDIS_HOST = os.getenv("REDIS_HOST", "redis")
REDIS_PORT = int(os.getenv("REDIS_PORT", "6379"))

redis_client = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)

async def init_redis():
    try:
        await redis_client.ping()
    except Exception:
        # connection will be attempted lazily by redis client on first use
        pass

def cached(ttl=60):
    def _decor(fn):
        async def wrapper(*args, **kwargs):
            # simplistic cache decorator placeholder
            return await fn(*args, **kwargs)
        return wrapper
    return _decor
