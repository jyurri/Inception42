VOLUMES := db wordpress
VOL_DIR = $(HOME)/jyurrita/data
VOLUME = $(addprefix $(VOL_DIR)/,$(VOLUMES))
DOCKER_COMPOSE_PATH = ./srcs/docker-compose.yml

run: $(VOLUME)
	docker compose -f $(DOCKER_COMPOSE_PATH) up --build --remove-orphans

down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down 

re:
	sudo rm -rf $(VOL_DIR)
	make down
	make 



$(VOLUME):
	mkdir -p $(VOLUME) 2>/dev/null