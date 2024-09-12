DOCKER_CMD = docker
COMPOSE_CMD = docker compose
COMPOSE_FILE = srcs/docker-compose.yml

all: up

build:
	sudo mkdir -p /home/mafissie/data/wordpress
	sudo mkdir -p /home/mafissie/data/mariadb
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) build

up: build
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) up -d

start:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) start

stop:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) stop

down:
	sudo rm -rf /home/mafissie/data
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) down -v --rmi all

re: down all

cmd:
	@echo "CONTAINERS"
	@$(DOCKER_CMD) ps -a
	@echo "\nVOLUMES"
	@$(DOCKER_CMD) volume ls
	@echo "\nIMAGES"
	@$(DOCKER_CMD) image ls
	@echo "\nNETWORKS"
	@$(DOCKER_CMD) network ls