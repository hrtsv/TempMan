#!/bin/sh
set -e

echo "Starting Flask application..."
python -m flask run --host=0.0.0.0
