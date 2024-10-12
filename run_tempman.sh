#!/bin/bash

# Create a temporary directory
temp_dir=$(mktemp -d)
cd "$temp_dir"

# Download the docker-compose.yml file
curl -O https://raw.githubusercontent.com/hrtsv/TempMan/main/docker-compose.yml

# Run docker-compose
docker-compose up -d

# Print instructions
echo "TempMan is now running. You can access it at http://localhost:5000"
echo "To stop the application, run: docker-compose down"
echo "To view logs, run: docker-compose logs -f"

# Cleanup
cd -
rm -rf "$temp_dir"
