# Use a minimal Python image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy the application code
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir flask pyghmi nvidia-ml-py3

# Expose port 5000 for the Flask app
EXPOSE 5000

# Set the entrypoint
CMD ["python", "app.py"]
