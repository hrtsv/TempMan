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

4. Deploy the stack in Dockge.

5. Once the deployment is complete, you can access the application by opening a web browser and navigating to:

   http://your-server-ip:5000

   Replace `your-server-ip` with the IP address or hostname of the server running Dockge.

## Features

- Flask backend with JWT authentication
- React frontend
- IPMI and NVIDIA SMI data monitoring
- Containerized for easy deployment
- PostgreSQL database integration

## Prerequisites

- Dockge installed and running on your system

## Troubleshooting

If you encounter any issues with the deployment process:

1. Check the logs for the app service in Dockge:
   - In the Dockge interface, find your stack and click on it.
   - Look for the "app" service and click on the "Logs" button.
   - Review the logs for any error messages or debugging information.

2. Common issues to look out for:
   - If you see "No requirements.txt found", check the repository structure and ensure the file exists.
   - If you see "No frontend directory or package.json found", verify the frontend directory structure in the repository.

3. Ensure that port 5000 is not being used by another service on your system.

4. Verify that the PostgreSQL database is running correctly by checking its logs in Dockge.

If you need to modify the application, you can fork the TempMan repository, make your changes, and then update the `context` in the docker-compose.yml file to point to your forked repository.

## Contributing

For more information on contributing to this project, please refer to the repository at https://github.com/hrtsv/TempMan.git.

## License

Please refer to the LICENSE file in the repository for licensing information.
