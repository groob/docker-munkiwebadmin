DOCKER_USER=groob
ADMIN_PASS=pass
MUNKI_REPO_DIR=/tmp/munki_repo
MWA_PORT=80
DB_NAME=munkiwebadmin
DB_PASS=password
DB_USER=admin
DB_CONTAINER_NAME:=postgres-munkiwebadmin
NAME:=munkiwebadmin
DOCKER_RUN_COMMON=--name="$(NAME)" -p ${MWA_PORT}:80 --link $(DB_CONTAINER_NAME):db -v ${MUNKI_REPO_DIR}:/munki_repo -e ADMIN_PASS=${ADMIN_PASS} -e DB_NAME=$(DB_NAME) -e DB_USER=$(DB_USER) -e DB_PASS=$(DB_PASS) ${DOCKER_USER}/munkiwebadmin


all: build

build:
	docker build -t="${DOCKER_USER}/munkiwebadmin" .

run:
	mkdir -p ${MUNKI_REPO_DIR}
	docker run -d ${DOCKER_RUN_COMMON}

clean:
	docker stop $(NAME)
	docker rm $(NAME)
