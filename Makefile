all: up

up:
	mkdir -p srcs/volumes/{mariadb_data,wordpress_data}
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	rm -rf srcs/volumes
	docker-compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans

re: down up

mariadb:
	docker-compose -f srcs/docker-compose.yml exec mariadb bash

wordpress:
	docker-compose -f srcs/docker-compose.yml exec wordpress bash

nginx:
	docker-compose -f srcs/docker-compose.yml exec nginx bash

ps:
	docker-compose -f srcs/docker-compose.yml ps

logs:
	docker-compose -f srcs/docker-compose.yml logs

logs-follow:
	docker-compose -f srcs/docker-compose.yml logs -f

open:
	open -a "google chrome" "https://localhost"

check-ssl:
	openssl s_client -connect localhost:443 -tls1_2

admin:
	open -a "google chrome" "https://localhost/wp-admin"

.PHONY: all up down clean fclean re ps logs logs-follow
