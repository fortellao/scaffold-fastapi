from fastapi import FastAPI
from . import router as api_router

app = FastAPI(
    title="Scaffold FastAPI",
    description="A FastAPI scaffold application",
    version="0.1.0"
)

# Include API routes
app.include_router(api_router, prefix="/api")