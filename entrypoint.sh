#!/bin/sh
set -e

echo "Current directory contents:"
ls -R

echo "Checking for PostgreSQL processes:"
ps aux | grep postgres || echo "No PostgreSQL processes found"

if [ -f "backend/app.py" ]; then
    echo "Starting Flask application from backend directory..."
    cd backend
    python -m flask run --host=0.0.0.0
else
    echo "Error: app.py not found in backend directory"
    exit 1
fi
