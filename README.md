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

  db:
    image: postgres:13-alpine
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=ipmi_nvidia_db
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
    name: tempman_postgres_data
```

4. Click on "Create Stack" or the equivalent button in Dockge to deploy the stack.

5. Dockge will pull the necessary images, build the app container, and start the services.

6. Once the deployment is complete, you can access the application by opening a web browser and navigating to:

   http://your-server-ip:5000

   Replace `your-server-ip` with the IP address or hostname of the server running Dockge.

## Manual Deployment with Docker Compose

If you prefer to deploy manually using Docker Compose, follow these steps:

1. Save the above docker-compose.yml content to a file named `docker-compose.yml` in your desired directory.

2. Open a terminal and navigate to the directory containing the `docker-compose.yml` file.

3. Run the following command to start the services:

   ```bash
   docker-compose up -d
   ```

4. Access the application at http://localhost:5000

## Troubleshooting

If you encounter any issues with the deployment process:

1. Check the logs for the app service:
   - In Dockge: Find your stack, click on it, look for the "app" service, and click on the "Logs" button.
   - With Docker Compose: Run `docker-compose logs app`

2. Check the logs for the db service:
   - In Dockge: Look for the "db" service and check its logs.
   - With Docker Compose: Run `docker-compose logs db`

3. Common issues and solutions:
   - If you see "app.py not found in root or backend directory", check the repository structure and ensure the Flask application file is in the correct location.
   - If the app can't connect to the database, ensure the `DATABASE_URL` environment variable is correct and the database container is running.
   - If you see multiple PostgreSQL instances starting, ensure that the app container doesn't have PostgreSQL installed. Only the db service should be running PostgreSQL.

4. Ensure that port 5000 is not being used by another service on your system.

5. If you need to modify the application:
   - Fork the TempMan repository on GitHub.
   - Make your changes in the forked repository.
   - Update the `context` in the docker-compose.yml file to point to your forked repository:
     ```yaml
     build:
       context: https://github.com/your-username/TempMan.git#main
       dockerfile: Dockerfile
     ```
   - Redeploy the stack in Dockge or run `docker-compose up -d` again.

6. If you need to reinitialize the database:
   ```bash
   docker-compose down
   docker volume rm tempman_postgres_data
   docker-compose up -d
   ```

## Features

- Flask backend with JWT authentication
- React frontend
- IPMI and NVIDIA SMI data monitoring
- Containerized for easy deployment
- PostgreSQL database integration (as a separate service)

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
