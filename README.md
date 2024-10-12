# TempMan

TempMan is a Python Flask React SQL JWT app that utilizes IPMI and NVIDIA SMI in a Dockerfile environment.

## Quick Start with Docker

To run TempMan using Docker, follow these steps:

1. Ensure Docker is installed on your system.
2. Run the following command:

```bash
docker run -d -p 5000:5000 --name tempman $(docker build -q https://github.com/hrtsv/TempMan.git)
```

This command does the following:
- Clones the TempMan repository from GitHub
- Builds the Docker image using the Dockerfile in the repository
- Creates and runs a container from the newly built image

Command breakdown:
- `docker build -q https://github.com/hrtsv/TempMan.git`: Builds the Docker image from the GitHub repository
- `-q`: Outputs only the image ID
- `$(...)`: Substitutes the output (image ID) into the docker run command
- `docker run`: Creates and starts a container from the image
- `-d`: Runs the container in detached mode (in the background)
- `-p 5000:5000`: Maps port 5000 of the container to port 5000 on the host
- `--name tempman`: Names the container "tempman" for easy reference

3. Once the container is running, you can access the application by opening a web browser and navigating to:

   http://localhost:5000

## Features

- Flask backend with JWT authentication
- React frontend
- IPMI and NVIDIA SMI data monitoring
- Containerized for easy deployment

## Note

This Docker setup pulls the latest code from the GitHub repository, builds the image, and runs the container in a single command. If you need to make local changes, clone the repository first, make your changes, and then use `docker build` and `docker run` separately.

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
