# TempMan

TempMan is a Python Flask React SQL JWT app that utilizes IPMI and NVIDIA SMI in a Dockerfile environment.

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
      - DATABASE_URL=postgresql://postgres:password@db:5432/ipmi_nvidia_db
      - JWT_SECRET_KEY=your_secret_key_here
    depends_on:
      - db
    restart: unless-stopped
    command: |
      /bin/sh -c '
      echo "Dockerfile content:";
      cat Dockerfile;
      echo "Starting application...";
      /entrypoint.sh
      '

  db:
    image: postgres:13
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=ipmi_nvidia_db
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
```

4. Click on "Create Stack" or the equivalent button in Dockge to deploy the stack.

5. Dockge will pull the necessary images, build the app container, and start the services.

6. Once the deployment is complete, you can access the application by opening a web browser and navigating to:

   http://your-server-ip:5000

   Replace `your-server-ip` with the IP address or hostname of the server running Dockge.

## Troubleshooting

If you encounter any issues with the deployment process:

1. Check the logs for the app service in Dockge:
   - In the Dockge interface, find your stack and click on it.
   - Look for the "app" service and click on the "Logs" button.
   - Review the logs for any error messages or debugging information.

2. Common issues and solutions:
   - If you see "No requirements.txt found", check the repository structure and ensure the file exists in the backend directory.
   - If you encounter frontend build issues:
     - The Dockerfile is set up to create basic React files if they don't exist. Check the logs to see if these files were created successfully.
     - If you need to customize the frontend, you may need to fork the repository and modify the frontend files directly.

3. Ensure that port 5000 is not being used by another service on your system.

4. Verify that the PostgreSQL database is running correctly by checking its logs in Dockge.

5. If you need to modify the application:
   - Fork the TempMan repository on GitHub.
   - Make your changes in the forked repository.
   - Update the `context` in the docker-compose.yml file to point to your forked repository:
     ```yaml
     build:
       context: https://github.com/your-username/TempMan.git#main
       dockerfile: Dockerfile
     ```
   - Redeploy the stack in Dockge with the updated docker-compose.yml file.

6. If you're still encountering issues, you can try to build the Docker image manually to see more detailed error messages:
   ```
   docker build -t tempman https://github.com/hrtsv/TempMan.git#main
   ```
   This will show you the full build output and any potential errors.

## Features

- Flask backend with JWT authentication
- React frontend
- IPMI and NVIDIA SMI data monitoring
- Containerized for easy deployment
- PostgreSQL database integration

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
