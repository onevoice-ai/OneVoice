# Makefile for OneVoice.ai common services

# Define variables
PROJECT_NAME=onevoice-ai
INFRA_COMPOSE_FILE=docker-compose.yml
BACKEND_COMPOSE_FILE=./backend-service/docker-compose.yml
FRONTEND_COMPOSE_FILE=./frontend-service/docker-compose.yml
DASHBOARD_BACKEND_COMPOSE_FILE=./survey-dashboard-backend-service/docker-compose.yml
DASHBOARD_FRONTEND_COMPOSE_FILE=./survey-dashboard-frontend-service/docker-compose.yml

# Default command when you run just `make`
all: start

# Clone all services
clone: clone-frontend clone-backend

# Clone frontend services
clone-frontend:
	git clone git@github.com:onevoice-ai/frontend-service.git
	git clone git@github.com:onevoice-ai/survey-dashboard-frontend-service.git
	@echo "Cloned all frontend services successfully"

# Clone backend services
clone-backend:
	git clone git@github.com:onevoice-ai/backend-service.git
	git clone git@github.com:onevoice-ai/survey-dashboard-backend-service.git
	@echo "Cloned all backend services successfully"

# Clone core services
clone-core:
	git clone git@github.com:onevoice-ai/frontend-service.git
	git clone git@github.com:onevoice-ai/backend-service.git

# Clone survey dashboard services
clone-dashboard:
	git clone git@github.com:onevoice-ai/survey-dashboard-frontend-service.git
	git clone git@github.com:onevoice-ai/survey-dashboard-backend-service.git

# Migrate all the backend services
migrate:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) run --rm core-web python manage.py migrate
	@echo "##########################################"
	@echo "Migrated all backend services successfully"
	@echo "##########################################"
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) run --rm dashboard-web python manage.py migrate
	@echo "##########################################"
	@echo "Migrated all survey dashboard backend services successfully"
	@echo "##########################################"

# Populate all the backend services with initial data
populate:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) run --rm core-web python manage.py createadminuser
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) run --rm core-web python manage.py createtestuser
	@echo "##########################################"
	@echo "Populated all backend services successfully"
	@echo "##########################################"
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) run --rm dashboard-web python manage.py createadminuser
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) run --rm dashboard-web python manage.py createtestusers
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) run --rm dashboard-web python manage.py createtestdata
	@echo "##########################################"
	@echo "Populated all survey dashboard backend services successfully"
	@echo "##########################################"

# Start all services
start: start-infra start-core start-dashboard

# Development environment
start-infra:
	docker compose -f $(INFRA_COMPOSE_FILE) -p $(PROJECT_NAME) up -d

# Start frontend services
start-frontend:
	docker compose -f $(FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) up -d
	docker compose -f $(DASHBOARD_FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) up -d

# Start backend services
start-backend:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) up -d
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) up -d

# Start core service
start-core:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) up -d
	docker compose -f $(FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) up -d

# Start survey dashboard service
start-dashboard:
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) up -d
	docker compose -f $(DASHBOARD_FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) up -d

# Stop all running containers
down: down-dashboard down-core down-infra

# Stop infrastructure services
down-infra:
	docker compose -f $(INFRA_COMPOSE_FILE) -p $(PROJECT_NAME) down

# Stop frontend services
down-frontend:
	docker compose -f $(FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) down
	docker compose -f $(DASHBOARD_FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) down

# Stop backend services
down-backend:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) down
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) down

# Stop core services
down-core:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) down
	docker compose -f $(FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) down

# Stop survey dashboard services
down-dashboard:
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) down
	docker compose -f $(DASHBOARD_FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) down

# Remove all Docker images and containers (use with caution)
clean:
	make clean-infra
	make clean-core
	make clean-dashboard
	docker system prune -af --volumes

# Remove infrastructure Docker images and containers
clean-infra:
	docker compose -f $(INFRA_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v

# Remove frontend Docker images and containers
clean-frontend:
	docker compose -f $(FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v
	docker compose -f $(DASHBOARD_FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v

# Remove backend Docker images and containers
clean-backend:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v

# Remove core Docker images and containers
clean-core:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v
	docker compose -f $(FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v

# Remove survey dashboard Docker images and containers
clean-dashboard:
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v
	docker compose -f $(DASHBOARD_FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) down --rmi all -v

# Remove all services
delete: delete-frontend delete-backend

# Remove backend services
delete-backend:
	rm -rf backend-service
	rm -rf survey-dashboard-backend-service

# Remove frontend services
delete-frontend:
	rm -rf frontend-service
	rm -rf survey-dashboard-frontend-service

# Remove core services
delete-core:
	rm -rf frontend-service
	rm -rf backend-service

# Remove survey dashboard services
delete-dashboard:
	rm -rf survey-dashboard-frontend-service
	rm -rf survey-dashboard-backend-service

# Show logs for core backend services
log-core-backend:
	docker compose -f $(BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) logs -f core-web

# Show logs for core frontend services
log-core-frontend:
	docker compose -f $(FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) logs -f core-frontend

# Show logs for survey dashboard backend services
log-dashboard-backend:
	docker compose -f $(DASHBOARD_BACKEND_COMPOSE_FILE) -p $(PROJECT_NAME) logs -f dashboard-web

# Show logs for survey dashboard frontend services
log-dashboard-frontend:
	docker compose -f $(DASHBOARD_FRONTEND_COMPOSE_FILE) -p $(PROJECT_NAME) logs -f dashboard-frontend

# Help command to display available commands
help:
	@echo "Available commands:"
	@echo "  clone        			Clone all services"
	@echo "  clone-frontend 		Clone frontend services"
	@echo "  clone-backend 		Clone backend services"
	@echo "  clone-core 			Clone core services"
	@echo "  clone-dashboard 		Clone survey dashboard services"
	@echo "  migrate        		Migrate all the backend services"
	@echo "  populate        		Populate all the backend services with initial data"
	@echo "  start        			Start all services"
	@echo "  start-infra 			Start the infrastructure services"
	@echo "  start-frontend 		Start the frontend services"
	@echo "  start-backend 		Start the backend services"
	@echo "  start-core 			Start the core services"
	@echo "  start-dashboard 		Start the survey dashboard services"
	@echo "  down        			Stop all running services"
	@echo "  down-infra 			Stop the infrastructure services"
	@echo "  down-frontend 		Stop the frontend services"
	@echo "  down-backend 			Stop the backend services"
	@echo "  down-core 			Stop the core services"
	@echo "  down-dashboard 		Stop the survey dashboard services"
	@echo "  clean        			Remove all services"
	@echo "  clean-infra 			Remove all infrastructure services"
	@echo "  clean-frontend 		Remove all frontend services"
	@echo "  clean-backend 		Remove all backend services"
	@echo "  clean-core 			Remove all core services"
	@echo "  clean-dashboard 		Remove all survey dashboard services"
	@echo "  delete        		Remove all services"
	@echo "  delete-frontend 		Remove frontend services"
	@echo "  delete-backend 		Remove backend services"
	@echo "  delete-core 			Remove core services"
	@echo "  delete-dashboard 		Remove survey dashboard services"
	@echo "  log-core-backend 	Show logs for core backend services"
	@echo "  log-core-frontend 	Show logs for core frontend services"
	@echo "  log-dashboard-backend Show logs for survey dashboard backend services"
	@echo "  log-dashboard-frontend Show logs for survey dashboard frontend services"
	@echo "  help        			Display this help message"

.PHONY: all clone clone-frontend clone-backend clone-core clone-dashboard start start-infra start-frontend start-backend start-core start-dashboard down down-infra down-frontend down-backend down-core down-dashboard clean clean-infra clean-frontend clean-backend clean-core clean-dashboard delete delete-frontend delete-backend delete-core delete-dashboard help

