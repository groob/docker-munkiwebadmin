docker-munkiwebadmin
==========

This Docker container runs [MunkiWebAdmin](https://github.com/munki/munkiwebadmin).
The container expects a linked PostgreSQL database container and that your munki repo is mounted
in /munki_repo

Several options, such as the timezone and admin password are customizable using environment variables.

# Postgres container

You must run the PostgreSQL container before running the munkiwebadmin container.
Currently there is support only for PostgreSQL.
The supported way to run the container is using the [official postgres container](https://registry.hub.docker.com/u/library/postgres/) from the Docker Hub, but you can use your own. The app container expects the following environment variables to connect to a database:

DB_NAME
DB_USER
DB_PASS

```bash
$ docker pull postgres
$ docker run -d --name postgres-munkiwebadmin \
    -e POSTGRES_DB=munkiwebadmin \
    -e POSTGRES_USER=admin \
    -e POSTGRES_PASSWORD=password \
    --volumes-from pgdata-mwa postgres
```

# Running the MunkiWebAdmin Container

```bash
$ docker run -d --name="munkiwebadmin" \
  -p 80:80 \
  --link postgres-munkiwebadmin:db \
  -v /tmp/munki_repo:/munki_repo \
  -e ADMIN_PASS=pass \
  -e DB_NAME=munkiwebadmin \
  -e DB_USER=admin \
  -e DB_PASS=password \
  macadmins/munkiwebadmin:latest
```
See guide on [linking containers](https://docs.docker.com/userguide/dockerlinks/).

