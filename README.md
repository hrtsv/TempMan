# TempMan

TempMan is a Python Flask React JWT app that utilizes IPMI and NVIDIA SMI in a Dockerfile environment.

## Deploying with Docker Compose

To deploy TempMan using Docker Compose, follow these steps:

1. Ensure you have Docker and Docker Compose installed on your system.

2. Clone the repository:
   ```
   git clone https://github.com/hrtsv/TempMan.git
   cd TempMan
   ```

3. Create a `docker-compose.yml` file in the root directory with the following content:

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "5000:5000"
    environment:
      - FLASK_APP=backend/app.py
      - FLASK_RUN_HOST=0.0.0.0
    restart: unless-stopped
```

4. Run the following command to start the service:

```bash
docker-compose up -d
```

5. Once the deployment is complete, you can access the application by opening a web browser and navigating to:

   http://localhost:5000

## Troubleshooting

If you encounter any issues with the deployment process:

1. Check the logs for the app service:
   ```bash
   docker-compose logs app
   ```

2. Common issues and solutions:
   - If the app fails to start, check the Dockerfile and ensure all dependencies are correctly installed.
   - If you can't access the application, ensure that port 5000 is not being used by another service on your system.

3. If you need to rebuild the container after making changes:
   ```bash
   docker-compose down
   docker-compose up -d --build
   ```

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
