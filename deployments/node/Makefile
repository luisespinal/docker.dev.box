# build file for FireFly TOR management service
TSTAMP := $(shell date -u '+%Y.%M.%d.%H.%m.%s.%Z')
VERSION := $(shell git describe --tags 2> /dev/null || echo SNAPSHOT)
BUILD := $(shell git rev-parse --short HEAD 2> /dev/null || echo none)
PROJECTNAME := $(shell basename "$(PWD)")

APPUID = $(shell id -u)
APPGID = $(shell id -g)

ENV_VARS = APP_HOME=$(NODE_APP_HOME) CONTAINER_NAME=$(NODE_DEV_CONTAINER_NAME)
COMPOSE  = $(ENV_VARS) $(shell which docker-compose)
DOCKER   = $(ENV_VARS) $(shell which docker)

.PHONY: build
build:
	$(DOCKER) build \
		--build-arg group_id=$(APPUID) \
		--build-arg user_id=$(APPUID) \
		--build-arg app_name=node_dev \
		--tag node_dev .

## local-docker-up: docker-compose up, make sure that you export your github access_code as env variable
.PHONY: run
run:
	$(COMPOSE) run node_dev /bin/bash

## local-docker-down: docker-compose down
.PHONY: down
down:
	$(COMPOSE) down

.PHONE: up
up:
	$(COMPOSE) up

.PHONE: shell
shell:
	$(COMPOSE) exec node_dev /bin/bash

.PHONY: clean
clean:
	docker container prune --force --filter label=docker.dev.box.name=node_dev
	docker image prune -a --force --filter label=docker.dev.box.name=node_dev

## help: Print usage information
.PHONY: help
help: Makefile
	@echo
	@echo "Choose a command to run in $(PROJECTNAME):"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' | sed -e 's/^/ /'
	@echo
		  