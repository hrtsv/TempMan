# Use Alpine-based Python image
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache git nodejs npm

# Clone the repository
RUN git clone https://github.com/hrtsv/TempMan.git .

# Print directory contents for debugging
RUN echo "Contents of /app:" && ls -R

# Install Python dependencies
RUN if [ -f "requirements.txt" ]; then \
        pip install --no-cache-dir -r requirements.txt; \
    elif [ -f "app/requirements.txt" ]; then \
        pip install --no-cache-dir -r app/requirements.txt; \
    else \
        echo "requirements.txt not found"; \
        exit 1; \
    fi

# Install Node.js dependencies and build the React app
WORKDIR /app/frontend
RUN if [ -d "frontend" ]; then \
        cd frontend && npm install && npm run build; \
    elif [ -d "app/frontend" ]; then \
        cd app/frontend && npm install && npm run build; \
    else \
        echo "Frontend directory not found"; \
        exit 1; \
    fi

# Move back to the main directory
WORKDIR /app

# Expose port 5000 for the Flask app
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
