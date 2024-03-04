# OneVoice.ai Master Docker Services

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
- **start**: Builds and starts the containers.
- **down**: Stops and removes the containers and networks.
- **clean**: Removes containers, networks, images, and volumes, then prunes the system.
- **help**: Displays the available commands.

## Customization
You can customize the Docker Compose and shell scripts to fit your project's needs. For example, adjusting the exposed ports or adding new services to the `docker-compose.yml` file.

## Contribution
Contributions to the Master Docker Services repository are welcome. Please ensure to follow the project's coding and commit message guidelines.

## Support
For support and further assistance, please contact the OneVoice.ai development team.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

