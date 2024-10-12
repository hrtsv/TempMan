# TempMan

TempMan is a Python Flask React SQL JWT app that utilizes IPMI and NVIDIA SMI in a Dockerfile environment.

## Quick Start with Docker Compose

To run TempMan using Docker Compose, follow these steps:

1. Ensure Docker and Docker Compose are installed on your system.
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
      - DATABASE_URL=postgresql://user:password@db:5432/ipmi_nvidia_db
      - JWT_SECRET_KEY=your_secret_key_here
    depends_on:
      - db

  db:
    image: postgres:13
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=ipmi_nvidia_db
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

4. Run the following command in the directory containing the `docker-compose.yml` file:

```bash
docker-compose up -d
```

This command will:
- Build the Docker image for the app
- Pull the PostgreSQL image
- Create and start containers for both the app and the database

5. Once the containers are running, you can access the application by opening a web browser and navigating to:

   http://localhost:5000

## Features

- Flask backend with JWT authentication
- React frontend
- IPMI and NVIDIA SMI data monitoring
- Containerized for easy deployment
- PostgreSQL database integration

## Prerequisites

- Docker and Docker Compose must be installed on your system

## Troubleshooting

If you encounter any issues with the build process, you can try building the Docker image manually to see more detailed error messages:

```bash
docker build -t tempman .
```

This will show you the full build output and any potential errors.

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
