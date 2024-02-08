COMPOSE_FILE := srcs/docker-compose.yml

all: ssl-gen build up

build:
	mkdir -p /home/abravo/data/database
	mkdir -p /home/abravo/data/website
	# mkdir -p /home/amanda/data/database
	# mkdir -p /home/amanda/data/website
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

clean:
	docker compose -f $(COMPOSE_FILE) down -v
	yes | docker image prune
	yes | docker container prune
	yes	| docker volume prune
	docker image rm mariadb; docker image rm wordpress; docker image rm nginx; echo "done"
	rm -rf /home/abravo/data/database
	rm -rf /home/abravo/data/website


ssl-gen:
	@if [ ! -f srcs/requirements/nginx/tools/ssl/certs/inception.crt ] || [ ! -f srcs/requirements/nginx/tools/ssl/private/inception.key ]; then \
		openssl req -x509 -nodes -out srcs/requirements/nginx/tools/ssl/certs/inception.crt -keyout \
		srcs/requirements/nginx/tools/ssl/private/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=abravo.42.fr/UID=abravo"; \
	else \
		echo "SSL certificate and key already exist."; \
	fi

.PHONY: all build up down logs ssl-gen clean