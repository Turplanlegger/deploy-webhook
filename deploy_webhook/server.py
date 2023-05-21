from fastapi import FastAPI
from deploy_webhook.__about__ import __version__

def create_app() -> FastAPI:
    app = FastAPI(
        title="Webhook",
        description="webhook",
        version=__version__
    )
    
    @app.get("/test")
    async def test():
        return {"status": "ok"}

    @app.get("/version")
    async def get_version():
        return {"version": __version__}

    return app

app = create_app()
