#!/bin/sh
set -e

echo "Current directory contents:"
ls -R

echo "Checking for PostgreSQL processes:"
ps aux | grep postgres || echo "No PostgreSQL processes found"

echo "Checking for PostgreSQL-related files:"
find / -name "*postgres*" 2>/dev/null || echo "No PostgreSQL-related files found"

if [ -f "app.py" ]; then
    echo "Starting Flask application from root directory..."
    python -m flask run --host=0.0.0.0
elif [ -f "backend/app.py" ]; then
    echo "Starting Flask application from backend directory..."
    cd backend
    python -m flask run --host=0.0.0.0
else
    echo "Error: app.py not found in root or backend directory"
    exit 1
fi
