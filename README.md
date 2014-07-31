docker-munkiwebadmin
==========

This Docker container runs [MunkiWebAdmin](https://code.google.com/p/munki/wiki/MunkiWebAdmin).
The container expects a linked PostgreSQL database container and that your munki repo is mounted
in /munki_repo

Several options, such as the timezone and admin password are customizable using environment variables.

#Postgres container
You must run the PostgreSQL container before running the munkiwebadmin container.
Currently there is support only for PostgreSQL.
I use the [stackbrew postgres container](https://registry.hub.docker.com/_/postgres/) from the Docker Hub, but you can use your own. The app container expects the following environment variables to connect to a database:
DB_NAME
DB_USER
DB_PASS

See [this blog post](http://davidamick.wordpress.com/2014/07/19/docker-postgresql-workflow/) for an example for an example workflow using the postgres container.
The setup_db.sh script in the GitHub repo will create the database tables for you.
The official guide on [linking containers](https://docs.docker.com/userguide/dockerlinks/) is also very helpful.

```bash
$ docker pull postgres
$ docker run --name="postgres-munkiwebadmin" -d postgres
# Edit the setup.db scrip from the github repo to change the database name, user and password before running it.
$ ./setup_db.sh
```

#Image Creation
```$ docker build -t="groob/munkiwebadmin" .```

#Running the MunkiWebAdmin Container

```bash
$ docker run -d --name="munkiwebadmin" \
  -p 80:80 \
  --link postgres-munkiwebadmin:db \
  -v /tmp/munki_repo:/munki_repo \
  -e ADMIN_PASS=pass \
  -e DB_NAME=munkiwebadmin \
  -e DB_USER=admin \
  -e DB_PASS=password \
  groob/munkiwebadmin
```
This assumes your Munki repo is mounted at /tmp/munki_repo.

#TODO
* add support for logging
* add more configuration options using environment variables
* add support for sqlite and mysql
* add support for SSL
