FROM python:3.11-slim

WORKDIR /app

# Install necessary system packages explicitly
RUN apt-get update && \
    apt-get install -y curl wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies explicitly
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy scripts, data, and environment explicitly
COPY scripts/ /app/scripts/
COPY data/ /app/data/
COPY .env /app/

# Entrypoint script explicitly
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]