# TempMan

TempMan is a simple Python Flask application that monitors IPMI and NVIDIA GPU temperatures and displays them on a web GUI.

## Features

- Monitors IPMI system temperature
- Monitors NVIDIA GPU temperature
- Displays temperatures on a simple web interface

## Prerequisites

- Dockge installed on your system
- IPMI and NVIDIA GPU hardware accessible on the host system
- Traefik (or similar reverse proxy) configured in your Dockge environment

## Deploying TempMan with Dockge

To deploy TempMan using Dockge, follow these steps:

1. In the Dockge web interface, create a new stack.

2. When prompted for the YAML file, use the following content:

```yaml
name: tempman
image: hrtsv/tempman:latest
restart: unless-stopped
devices:
  - /dev/ipmi0:/dev/ipmi0
  - /dev/nvidia0:/dev/nvidia0
privileged: true
labels:
  - "com.github.repo=https://github.com/hrtsv/TempMan.git"
  - "traefik.enable=true"
  - "traefik.http.routers.tempman.rule=Host(`tempman.yourdomain.com`)"
  - "traefik.http.services.tempman.loadbalancer.server.port=5000"
```

3. Replace `tempman.yourdomain.com` with your actual domain or subdomain.

4. Click on "Create Stack" or the equivalent button in Dockge to deploy the stack.

5. Dockge will pull the Docker image and start the container.

## Accessing the Application

Once deployed, you can access the application by opening a web browser and navigating to:

http://tempman.yourdomain.com

Replace `tempman.yourdomain.com` with the domain or subdomain you specified in the Dockge configuration.

## Troubleshooting

If you encounter any issues with the deployment process:

1. Check the logs for the app container in the Dockge interface.

2. Common issues and solutions:
   - If you can't access the application, ensure that your Traefik configuration is correct and that the domain is properly set up.
   - If IPMI or NVIDIA temperatures are not displayed, ensure that the necessary devices are properly mapped to the container and that you have the required permissions to access them.

3. If you need to update to the latest version of the application:
   - In Dockge, find your stack and use the "Pull" option to fetch the latest image.
   - After pulling, use the "Recreate" option to restart the container with the new image.

## Source Code

The source code for this application is available on GitHub:
https://github.com/hrtsv/TempMan.git

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
