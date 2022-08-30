TSTAMP         := $(shell date -u '+%Y.%M.%d.%H.%m.%s.%Z')
VERSION        := $(shell git describe --tags 2> /dev/null || echo SNAPSHOT)
BUILD          := $(shell git rev-parse --short HEAD 2> /dev/null || echo none)
PROJECTNAME    := $(shell basename "$(PWD)")

APPUID         := $(shell id -u)
APPGID         := $(shell id -g)

STACK          := node
DEFAULT_SHELL  := /bin/bash

APP_HOME       ?= $(shell pwd)
CONTAINER_NAME ?= $(PROJECTNAME)_cnt
TAG            ?= $(STACK)_dev

ENV_VARS       := APP_HOME=$(APP_HOME) CONTAINER_NAME=$(CONTAINER_NAME) TAG=$(TAG)
COMPOSE        := $(ENV_VARS) $(shell which docker-compose)
DOCKER         := $(ENV_VARS) $(shell which docker)



.PHONY: build
build:
	$(DOCKER) build \
		--build-arg group_id=$(APPUID) \
		--build-arg user_id=$(APPUID) \
		--build-arg type=$(STACK) \
		--build-arg app_name=$(TAG) \
		--tag $(TAG) .

## local-docker-up: docker-compose up, make sure that you export your github access_code as env variable
.PHONY: run
run:
	$(COMPOSE) run $(TAG) /bin/bash

## local-docker-down: docker-compose down
.PHONY: down
down:
	$(COMPOSE) down

.PHONE: up
up:
	$(COMPOSE) up

.PHONE: shell
shell:
	$(COMPOSE) exec $(TAG) $(DEFAULT_SHELL)

.PHONY: clean
clean:
	docker container prune --force --filter label=docker.dev.box.name=$(TAG)
	docker image prune -a --force --filter label=docker.dev.box.name=$(TAG)

## help: Print usage information
.PHONY: help
help: Makefile
	@echo
	@echo "Choose a command to run in $(PROJECTNAME):"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' | sed -e 's/^/ /'
	@echo
	@echo VARS:
	@echo APP_HOME:$(APP_HOME)
	@echo PROJECTNAME:$(PROJECTNAME)
	@echo CONTAINER_NAME:$(CONTAINER_NAME)
	@echo ENV_VARS:$(ENV_VARS)
	@echo DOCKER:$(DOCKER)
	@echo COMPOSE:$(COMPOSE)
	@echo TAG:$(TAG)
