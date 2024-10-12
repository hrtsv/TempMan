# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/hrtsv/TempMan.git .

# Install Python dependencies
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Node.js dependencies and build the React app
WORKDIR /app/frontend
RUN npm install && npm run build

# Move back to the main directory
WORKDIR /app

# Expose port 5000 for the Flask app
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=backend/app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Run the application
CMD ["python", "backend/app.py"]
