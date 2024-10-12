#!/bin/sh
set -e

echo "Current directory contents:"
ls -R

echo "Starting Flask application..."
python -m flask run --host=0.0.0.0
