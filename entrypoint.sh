#!/bin/sh
set -e

echo "Current directory contents:"
ls -R

if [ -f "app.py" ]; then
    echo "Starting Flask application from root directory..."
    python -m flask run --host=0.0.0.0
elif [ -f "app/app.py" ]; then
    echo "Starting Flask application from app directory..."
    cd app
    python -m flask run --host=0.0.0.0
else
    echo "Error: app.py not found"
    exit 1
fi
