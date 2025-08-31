FROM python:3.13-slim-bookworm
LABEL authors="fortellao"

# Install uv as root
RUN pip install uv

# Create a non-root user
RUN groupadd --system --gid 1001 appgroup
RUN useradd --system --uid 1001 --gid appgroup --shell /bin/bash appuser

# Create and set permissions for the app directory and cache directory
RUN mkdir -p /app /app/.cache
RUN chown -R appuser:appgroup /app
WORKDIR /app

# Copy dependency files (as root, then change ownership)
COPY pyproject.toml uv.lock ./
COPY src/ ./src
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Create virtual environment and install dependencies
RUN python -m venv .venv
ENV PATH=/app/.venv/bin:$PATH
ENV UV_CACHE_DIR=/app/.cache
RUN uv sync

# Expose port (for documentation, not required)
EXPOSE 8000

CMD ["uvicorn","rest_api.main:app","--port", "8000", "--host", "0.0.0.0", "--app-dir", "src"]
