# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    nodejs \
    npm \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/hrtsv/TempMan.git .

# Debug: Print directory contents
RUN echo "Contents of /app:" && ls -R /app

# Install Python dependencies
RUN if [ -f "requirements.txt" ]; then \
        echo "Installing from root requirements.txt" && \
        pip install --no-cache-dir -r requirements.txt; \
    elif [ -f "backend/requirements.txt" ]; then \
        echo "Installing from backend/requirements.txt" && \
        pip install --no-cache-dir -r backend/requirements.txt; \
    elif [ -f "app/backend/requirements.txt" ]; then \
        echo "Installing from app/backend/requirements.txt" && \
        pip install --no-cache-dir -r app/backend/requirements.txt; \
    else \
        echo "No requirements.txt found" && \
        exit 1; \
    fi

# Install Node.js dependencies and build the React app
WORKDIR /app/frontend
RUN if [ -d "frontend" ]; then \
        cd frontend && npm install && npm run build; \
    elif [ -f "package.json" ]; then \
        npm install && npm run build; \
    else \
        echo "No frontend directory or package.json found" && exit 1; \
    fi

# Move back to the main directory
WORKDIR /app

# Expose port 5000 for the Flask app
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV DATABASE_URL=postgresql://postgres:password@localhost:5432/ipmi_nvidia_db
ENV JWT_SECRET_KEY=your_secret_key_here

# Create a new PostgreSQL database
RUN service postgresql start && \
    su - postgres -c "createdb ipmi_nvidia_db" && \
    su - postgres -c "psql -c \"ALTER USER postgres WITH PASSWORD 'password';\""

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
