build: 
	sudo docker-compose -f srcs/docker-compose.yml build
up:
	sudo docker-compose -f srcs/docker-compose.yml up -d
down:
	sudo docker-compose -f srcs/docker-compose.yml down