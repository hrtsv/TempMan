# TempMan

TempMan is a Python Flask React SQL JWT app that utilizes IPMI and NVIDIA SMI in a Dockerfile environment.

## Quick Start with Docker

To run TempMan using a single Docker command, follow these steps:

1. Ensure Docker is installed on your system.

2. Run the following command:

```bash
docker run -d -p 5000:5000 --name tempman $(docker build -q .)
```

This command will:
- Build the Docker image using the Dockerfile in the current directory
- Create and start a container with both the app and the PostgreSQL database

3. Once the container is running, you can access the application by opening a web browser and navigating to:

   http://localhost:5000

## Features

- Flask backend with JWT authentication
- React frontend
- IPMI and NVIDIA SMI data monitoring
- Containerized for easy deployment
- PostgreSQL database integration

## Prerequisites

- Docker must be installed on your system

## Troubleshooting

If you encounter any issues with the build process, you can try building the Docker image manually to see more detailed error messages:

```bash
docker build -t tempman .
```

This will show you the full build output and any potential errors.

To run the container after a manual build:

```bash
docker run -d -p 5000:5000 --name tempman tempman
```

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
