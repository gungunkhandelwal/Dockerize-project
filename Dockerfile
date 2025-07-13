# # Use Python 3.11 slim image
# FROM python:3.11-slim

# # Set environment variables
# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1

# # Set work directory
# WORKDIR /app

# # Install system dependencies
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#         postgresql-client \
#         gcc \
#         python3-dev \
#         libpq-dev \
#         ffmpeg \
#     && rm -rf /var/lib/apt/lists/*

# # Copy requirements file
# COPY requirements.txt .

# # Install Python dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy project
# COPY . .

# # Create necessary directories
# RUN mkdir -p /app/media
# RUN mkdir -p /tmp/rail_sathi_temp

# # Make wait-for-it script executable
# RUN chmod +x wait-for-it.sh

# # Expose port
# EXPOSE 8000

# # Command to run the application with wait script
# CMD ["./wait-for-it.sh", "db", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


# Use Python 3.11 slim image
FROM python:3.11-slim

# Set environment variables
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

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Create necessary directories
RUN mkdir -p /app/media
RUN mkdir -p /tmp/rail_sathi_temp

# Create a simple wait script
RUN echo '#!/bin/bash\n\
while ! pg_isready -h db -p 5432 -U postgres; do\n\
  echo "Waiting for postgres..."\n\
  sleep 2\n\
done\n\
echo "PostgreSQL is ready!"\n\
exec "$@"' > /wait-for-postgres.sh && \
    chmod +x /wait-for-postgres.sh

# Expose port
EXPOSE 8000

# Command to run the application
CMD ["/wait-for-postgres.sh", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]