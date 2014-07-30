docker-munkiwebadmin
==========

This Docker container runs [MunkiWebAdmin](https://code.google.com/p/munki/wiki/MunkiWebAdmin).
The container expects a linked PostgreSQL database container.
Several options, such as the timezone and admin password are customizable using environment variables.

#PostgreSQL container
You must run the PostgreSQL container before running the munkiwebadmin container.
Currently there is support only for PostgreSQL.
I use the paintedfox/postgresql container from the Docker Hub.

```bash
$ docker pull paintedfox/postgresql

$ mkdir -p /tmp/postgresql
$ docker run -d --name="munkiwebadmin-postgresql" \
             -p 127.0.0.1:5432:5432 \
             -v /tmp/postgresql:/data \
             -e USER="admin" \
             -e DB="mwa_db" \
             -e PASS="$(pwgen -s -1 16)" \
              paintedfox/postgresql
```

Read the paintedfox/postgresql documentation on the Docker Hub [page](https://registry.hub.docker.com/u/paintedfox/postgresql/) or on [GitHub](https://github.com/Painted-Fox/docker-postgresql).

#Image Creation
```$ docker build -t="groob/munkiwebadmin" .```

#Running the MunkiWebAdmin Container

```bash
$ docker run -d --name="munkiwebadmin" \
             -p 80:80 \
             --link munkiwebadmin-postgresql \
             -v /tmp/munki_repo:/munki_repo \
             -e ADMIN_PASS="password"
             groob/munkiwebadmin
```
This assumes your Munki repo is mounted at /tmp/munki_repo.

#TODO
* add support for logging
* add more configuration options using environment variables
* add support for sqlite and mysql
* add support for SSL
