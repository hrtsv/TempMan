# TempMan

TempMan is a Python Flask React JWT app that utilizes IPMI and NVIDIA SMI in a Dockerfile environment.

## Deploying with Dockge

To deploy TempMan using Dockge, follow these steps:

1. Ensure you have Dockge installed and running on your system.

2. In the Dockge web interface, create a new stack.

3. When prompted for the docker-compose.yml file, use the following content:

```yaml
version: '3.8'

services:
  app:
    build:
      context: https://github.com/hrtsv/TempMan.git#main
      dockerfile: Dockerfile
    ports:
      - "5000:5000"
    environment:
      - FLASK_APP=backend/app.py
      - FLASK_RUN_HOST=0.0.0.0
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

networks:
  default:
    name: tempman_network
```

4. Click on "Create Stack" or the equivalent button in Dockge to deploy the stack.

5. Dockge will pull the necessary images, build the app container, and start the service.

6. Once the deployment is complete, you can access the application by opening a web browser and navigating to:

   http://your-server-ip:5000

   Replace `your-server-ip` with the IP address or hostname of the server running Dockge.

## Troubleshooting

If you encounter any issues with the deployment process:

1. Check the logs for the app service in Dockge:
   - Find your stack, click on it, look for the "app" service, and click on the "Logs" button.

2. Common issues and solutions:
   - If you see "Error: app.py not found in backend directory", check the repository structure and ensure the Flask application file is in the correct location (backend/app.py).
   - If you see any PostgreSQL-related messages or processes, please report this as an issue, as the application should not be starting PostgreSQL.
   - If the app fails to start, check the Dockerfile and ensure all dependencies are correctly installed.
   - If you can't access the application, ensure that port 5000 is not being used by another service on your system.

3. If you need to rebuild the container after making changes:
   - In Dockge, find your stack and use the "Recreate" option for the app service.

## Features

- Flask backend with JWT authentication
- React frontend
- IPMI and NVIDIA SMI data monitoring
- Containerized for easy deployment

## Database Configuration

This application does not include any database setup or configuration. If your project requires a database, you'll need to set it up separately and update the application code accordingly.

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
