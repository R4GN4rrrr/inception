all: up

up: 
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

build:
	@docker-compose -f ./srcs/docker-compose.yml build

stop:
	@docker-compose -f ./srcs/docker-compose.yml stop


logs:
	@docker-compose -f ./srcs/docker-compose.yml logs 



clean: 	
	@docker-compose -f ./srcs/docker-compose.yml down
	@docker system prune --force

re: 
	@docker-compose -f ./srcs/docker-compose.yml down
	@docker-compose -f ./srcs/docker-compose.yml up -d --build
