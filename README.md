# TempMan

TempMan is an application for monitoring temperatures and controlling fan speeds for IPMI and NVIDIA GPUs.

## Project Structure

The project consists of two main components:
- Backend: Located in the root directory
- Frontend: Located in the `frontend/` directory

Each component has its own Dockerfile:
- `Dockerfile.backend` in the root directory
- `Dockerfile.frontend` in the `frontend/` directory

## Deployment Instructions

To deploy TempMan using Docker and Dockge, follow these steps:

1. In your Dockge interface, create a new stack or edit an existing one.

2. Copy and paste the Docker Compose configuration from the `docker-compose.yml` file in this repository into the appropriate field in Dockge.

3. Set the following environment variables in Dockge's interface or replace the placeholders in the Docker Compose file:
   - `IPMI_HOST`: Your IPMI host address
   - `IPMI_USER`: Your IPMI username
   - `IPMI_PASSWORD`: Your IPMI password
   - `DB_PASSWORD`: A secure password for the database

4. Deploy the stack in Dockge.

After deployment, TempMan should be up and running, with both backend and frontend services available.

## Accessing TempMan

Once deployed, you can access the TempMan web interface by navigating to `http://<your-host-ip>` in your web browser, where `<your-host-ip>` is the IP address of the machine running the Docker containers.

## Data Persistence

This configuration uses Docker named volumes for data persistence:
- `tempman_data`: Stores the application data
- `tempman_pgdata`: Stores the database files

These volumes are managed by Docker and will persist data across container restarts and updates.

## Troubleshooting

If you encounter any issues during deployment or while running TempMan, please check the container logs in Dockge for error messages. If problems persist, please open an issue on the [TempMan GitHub repository](https://github.com/hrtsv/TempMan).
