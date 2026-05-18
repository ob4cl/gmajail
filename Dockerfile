FROM python:3.11-slim

LABEL org.opencontainers.image.title="gmajail"
LABEL org.opencontainers.image.description="Uncensored Gemma 4 web terminal — jailbroken AI chat"
LABEL org.opencontainers.image.url="https://github.com/ob4cl/gmajail"

WORKDIR /app

# Install deps
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY backend/ ./backend/
COPY frontend/ ./frontend/

EXPOSE 8080

ENV OLLAMA_HOST=http://host.docker.internal:11434
ENV GMAJAIL_PORT=8080
ENV PYTHONUNBUFFERED=1

CMD ["python3", "backend/server.py"]
