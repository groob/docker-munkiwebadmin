DOCKER_USER=groob
ADMIN_PASS=pass
MUNKI_REPO_DIR=/tmp/munki_repo
DB_DIR=/tmp/postgresql
MWA_PORT=80
DB_ENV_PASS=password
NAME:=munkiwebadmin
DB_NAME:=postgresql-munkiwebadmin
DOCKER_RUN_COMMON=--name="$(NAME)" -p ${MWA_PORT}:80 --link $(DB_NAME):db -v ${MUNKI_REPO_DIR}:/munki_repo -e ADMIN_PASS=${ADMIN_PASS} ${DOCKER_USER}/munkiwebadmin
RUNNING:=$(shell docker ps | grep $(NAME) | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep $(NAME) | cut -f 1 -d ' ')
DB_RUNNING:=$(shell docker ps | grep $(DB_NAME) | cut -f 1 -d ' ')
DB_ALL:=$(shell docker ps -a | grep $(DB_NAME) | cut -f 1 -d ' ')

all: build

build:
	docker build -t="${DOCKER_USER}/munkiwebadmin" .

run: clean rundb
	mkdir -p ${MUNKI_REPO_DIR}
	docker run -d ${DOCKER_RUN_COMMON}


rundb: cleandb
	docker pull paintedfox/postgresql
	mkdir -p $(DB_DIR)
	docker run -d --name="$(DB_NAME)" -p 127.0.0.1:5432:5432 -v ${DB_DIR}:/data -e USER="admin" -e DB="munkiwebadmin_db" -e PASS=${DB_ENV_PASS} paintedfox/postgresql

wipedb: cleandb
	rm -rf ${DB_DIR}

clean:
ifneq ($(strip $(RUNNING)),)
	docker stop $(RUNNING)
endif
ifneq ($(strip $(ALL)),)
	docker rm $(ALL)
endif

cleandb:
ifneq ($(strip $(DB_RUNNING)),)
	docker stop $(DB_RUNNING)
endif
ifneq ($(strip $(DB_ALL)),)
	docker rm $(DB_ALL)
endif
