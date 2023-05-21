FROM python:3.11-slim-bullseye

# Set work directory
WORKDIR /deploy-webhook

COPY . .

# Install build dependencies, then run `pip install`, then remove unneeded build dependencies all in a single step.
# Combined RUN statements into one to reduce number of image layers.
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    pip install --upgrade pip && \
    pip install --no-cache-dir . && \
    rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=5 CMD [ "curl", "-fs", "http://localhost:8000/test"]

CMD ["uvicorn", "deploy_webhook.server:app", "--host=0.0.0.0", "--workers=1"]

EXPOSE 8000
