# TempMan

TempMan is a Python Flask React SQL JWT app that utilizes IPMI and NVIDIA SMI in a Dockerfile environment.

## Quick Start

To run TempMan using a single command, follow these steps:

1. Ensure Docker and Docker Compose are installed on your system.

2. Run the following command in your terminal:

```bash
curl -sSL https://raw.githubusercontent.com/hrtsv/TempMan/main/run_tempman.sh | bash
```

This command will:
- Download the necessary files
- Pull the TempMan repository from GitHub
- Build the Docker image for the app
- Pull the PostgreSQL image
- Create and start containers for both the app and the database

3. Once the script completes, you can access the application by opening a web browser and navigating to:

   http://localhost:5000

## Features

- Flask backend with JWT authentication
- React frontend
- IPMI and NVIDIA SMI data monitoring
- Containerized for easy deployment
- PostgreSQL database integration

## Prerequisites

- Docker and Docker Compose must be installed on your system
- curl must be installed (comes pre-installed on most systems)

## Manual Setup (if needed)

If you prefer to set up the application manually or the quick start method doesn't work, you can follow these steps:

1. Clone the repository:
   ```
   git clone https://github.com/hrtsv/TempMan.git
   cd TempMan
   ```

2. Run Docker Compose:
   ```
   docker-compose up -d
   ```

## Troubleshooting

If you encounter any issues with the build process, you can try building the Docker image manually to see more detailed error messages:

```bash
docker build -t tempman https://github.com/hrtsv/TempMan.git#main
```

This will show you the full build output and any potential errors.

If the build is successful, you can run the container with:

```bash
docker run -d -p 5000:5000 --name tempman tempman
```

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
