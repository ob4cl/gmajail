FROM python:3.11-slim

LABEL org.opencontainers.image.title="gmajail"
LABEL org.opencontainers.image.description="Uncensored Gemma 4 web terminal — jailbroken AI chat"
LABEL org.opencontainers.image.url="https://github.com/ob4cl/gmajail"

# Create non-root user
RUN groupadd -r gmajail && useradd -r -g gmajail -d /app gmajail

WORKDIR /app

# Install deps
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY backend/ ./backend/
COPY frontend/ ./frontend/

# Set ownership
RUN chown -R gmajail:gmajail /app

EXPOSE 6969

ENV OLLAMA_HOST=http://host.docker.internal:11434
ENV GMAJAIL_PORT=6969
ENV PYTHONUNBUFFERED=1

USER gmajail

CMD ["python3", "backend/server.py"]
