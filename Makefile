# Makefile for OneVoice.ai common services

# Define variables
DEV_COMPOSE_FILE=docker-compose.yml
PROJECT_NAME=onevoice-ai

# Default command when you run just `make`
all: start

# Development environment
start:
	docker compose -f $(DEV_COMPOSE_FILE) -p $(PROJECT_NAME) up -d --build

# Stop all running containers
down:
	docker compose -f $(DEV_COMPOSE_FILE) down

# Remove all Docker images and containers (use with caution)
clean:
	docker compose -f $(DEV_COMPOSE_FILE) down --rmi all -v
	docker system prune -af --volumes

# Help command to display available commands
help:
	@echo "Available commands:"
	@echo "  start       Start the common services for development environment"
	@echo "  down        Stop all running containers"
	@echo "  clean       Remove all Docker images and containers"
	@echo "  help        Display this help message"

.PHONY: all start down clean help

