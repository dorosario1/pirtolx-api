from fastapi import FastAPI
import os

app = FastAPI(title="Pirtolx API")

@app.get("/health")
async def health():
    return {"status": "ok"}

# Example include of your app routes (adjust if your project layout differs)
if os.path.exists("src/app_router.py"):
    from src.app_router import router
    app.include_router(router)
