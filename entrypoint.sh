#!/bin/bash
set -e

# Start PostgreSQL service
service postgresql start

# Wait for PostgreSQL to be ready
until pg_isready; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

# Run Flask application
python backend/app.py
