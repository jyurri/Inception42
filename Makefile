VOLUMES := db wordpress
VOL_DIR = $(HOME)/data
VOLUME = $(addprefix $(VOL_DIR)/,$(VOLUMES))
DOCKER_COMPOSE_PATH = ./srcs/docker-compose.yml

run: $(VOLUME)
	docker compose -f $(DOCKER_COMPOSE_PATH) up --build --remove-orphans

down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down 

re:
	rm -rf $(VOL_DIR)
	make 



$(VOLUME):
	mkdir -p $(VOLUME) 2>/dev/null