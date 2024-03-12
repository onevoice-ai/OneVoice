# OneVoice.ai Master Repo

## Overview
This repository contains the Docker Compose configurations and supporting scripts required to set up common services for OneVoice.ai projects. It aims to facilitate the connection between different projects by establishing a common network and providing essential services like Redis and a Postgres database setup with master-slave replication.

## Services Included
- **Common Network**: Ensures all containers can communicate with each other.
- **Redis**: An in-memory database for fast data caching and retrieval.
- **Master Postgres Database**: The primary database for persistent data storage.
- **Slave Postgres Database**: A replica of the master database for read-heavy operations, ensuring load balancing and redundancy.

## Getting Started

### Prerequisites
Ensure Docker and Docker Compose are installed on your system. For installation instructions, visit [Docker's official documentation](https://docs.docker.com/get-docker/).

### Environment Setup
Before starting the services, configure the necessary environment variables by editing the `.env` file in the root directory. This file contains settings for the Postgres databases and any other service-specific configurations.

### Cloning the Repository
Clone the repository to your local machine using the following command:

```bash
git clone https://github.com/onevoice-ai/OneVoice.git
```

### Cloning all the Microservices
To clone all the microservices, run the following command:

```bash
make clone
```

### Cloning all the Frontend Microservices
To clone all the frontend microservices, run the following command:

```bash
make clone-frontend
```

### Cloning all the Backend Microservices
To clone all the backend microservices, run the following command:

```bash
make clone-backend
```

### Starting the Services
To start all services, use the following command:

```bash
make start
```

This command builds and starts all the defined services in detached mode, allowing them to run in the background.

### Stopping the Services
To stop all running services, execute:

```bash
make down
```

### Cleaning Up
To remove all containers, networks, and images created by the Docker Compose file, run:

```bash
make clean
```
**Caution**: This command will also remove all Docker volumes and prune the system, potentially affecting other Docker projects on your system.

## Makefile Commands
The Makefile contains several commands to simplify the management of the Docker services. The available commands are:
- **clone**: Clones all the microservices.
- **clone-frontend**: Clones all the frontend microservices.
- **clone-backend**: Clones all the backend microservices.
- **start**: Builds and starts the containers.
- **start-infra**: Builds and starts the infrastructure containers.
- **start-core**: Builds and starts the core containers.
- **start-dashboard**: Builds and starts the dashboard containers.
- **down**: Stops and removes the containers and networks.
- **down-infra**: Stops and removes the infrastructure containers and networks.
- **down-core**: Stops and removes the core containers and networks.
- **down-dashboard**: Stops and removes the dashboard containers and networks.
- **clean**: Removes containers, networks, images, and volumes, then prunes the system.
- **clean-infra**: Removes infrastructure containers, networks, images, and volumes.
- **clean-core**: Removes core containers, networks, images, and volumes.
- **clean-dashboard**: Removes dashboard containers, networks, images, and volumes.
- **delete**: Deletes all the microservices.
- **delete-frontend**: Deletes all the frontend microservices.
- **delete-backend**: Deletes all the backend microservices.
- **help**: Displays the available commands.

## Customization
You can customize the Docker Compose and shell scripts to fit your project's needs. For example, adjusting the exposed ports or adding new services to the `docker-compose.yml` file.

## Contribution
Contributions to the Master Docker Services repository are welcome. Please ensure to follow the project's coding and commit message guidelines.

## Support
For support and further assistance, please contact the OneVoice.ai development team.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

