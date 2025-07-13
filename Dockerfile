FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        gcc \
        python3-dev \
        libpq-dev \
        ffmpeg \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

RUN mkdir -p /app/media
RUN mkdir -p /tmp/rail_sathi_temp

RUN chmod +x wait-for-it.sh

# Expose port
EXPOSE 8000

# Command to run the application with wait script
CMD ["./wait-for-it.sh", "db", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]