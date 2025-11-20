import json
from typing import Callable
from functools import wraps
import redis.asyncio as redis

REDIS_URL = "redis://127.0.0.1:6379/0"
redis_client = None

async def init_redis(app=None):
    global redis_client
    if redis_client is None:
        redis_client = redis.from_url(REDIS_URL, decode_responses=True)
        try:
            await redis_client.ping()
        except Exception as e:
            print("Warning: Redis ping failed:", e)

def make_cache_key(prefix: str, *args, **kwargs) -> str:
    payload = {"args": args, "kwargs": kwargs}
    try:
        body = json.dumps(payload, sort_keys=True, default=str)
    except Exception:
        body = str(payload)
    return f"pirtolx:{prefix}:" + body

def cached(prefix: str, ttl: int = 60):
    def decorator(func: Callable):
        @wraps(func)
        async def wrapper(*args, **kwargs):
            global redis_client
            if redis_client is None:
                return await func(*args, **kwargs)
            key = make_cache_key(prefix, *args, **kwargs)
            try:
                cached_raw = await redis_client.get(key)
                if cached_raw:
                    return json.loads(cached_raw)
            except Exception:
                pass
            result = await func(*args, **kwargs)
            try:
                await redis_client.set(key, json.dumps(result, default=str), ex=ttl)
            except Exception:
                pass
            return result
        return wrapper
    return decorator
