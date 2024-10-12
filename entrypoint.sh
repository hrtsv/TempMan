#!/bin/bash
set -e

echo "Current directory contents:"
ls -R

echo "Checking for PostgreSQL processes:"
ps aux | grep postgres || echo "No PostgreSQL processes found"

echo "Checking for PostgreSQL-related files:"
find / -name "*postgres*" 2>/dev/null || echo "No PostgreSQL-related files found"

echo "Checking if PostgreSQL service exists:"
if systemctl list-unit-files | grep -q postgresql; then
    echo "PostgreSQL service found. Attempting to stop and disable..."
    systemctl stop postgresql || true
    systemctl disable postgresql || true
else
    echo "No PostgreSQL service found."
fi

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
