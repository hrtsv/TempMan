# TempMan

TempMan is a Python Flask React SQL JWT app that utilizes IPMI and NVIDIA SMI in a Dockerfile environment.

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
      - DATABASE_URL=postgresql://postgres:password@db:5432/ipmi_nvidia_db
      - JWT_SECRET_KEY=your_secret_key_here
    depends_on:
      - db
    restart: unless-stopped

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
    name: tempman_postgres_data
```

4. Run the following command to start the services:

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

2. Check the logs for the db service:
   ```bash
   docker-compose logs db
   ```

3. Common issues and solutions:
   - If the app can't connect to the database, ensure the `DATABASE_URL` environment variable is correct and the database container is running.
   - If you see any PostgreSQL-related processes in the app container, ensure that the Dockerfile and entrypoint.sh are correctly configured to not start PostgreSQL.

4. Ensure that port 5000 is not being used by another service on your system.

5. If you need to rebuild the containers after making changes:
   ```bash
   docker-compose down
   docker-compose up -d --build
   ```

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
