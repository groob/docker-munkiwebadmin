munkiwebadmin-docker
==========

Dockerfile for munkiwebadmin

#Munkiwebadmin container
the settings should be configured during the DB step. The munkiwebadmin container uses the linked db container.

#PostgreSQL container

For the database, I used a postgresql docker container. First you need to pull the container from the index.

```docker pull paintedfox/postgresql```

    docker run -d --name="mwa-postgresql" \
                 -p 127.0.0.1:5432:5432 \
                 -v /tmp/postgresql:/data \
                 -e USER="mwaadmin" \
                 -e DB="mwa_db" \
                 -e PASS="password" \
                 paintedfox/postgresql


##Build the MWA container.
In the folder with the Dockerfile, run

```docker build -t mwa .```
##run
```docker run --rm -t -i -p 80:80 --link mwa-postgresql:db  -v /tmp/munki_repo:/munki_repo:rw groob/mwa /sbin/my_init -- bash -l ```

I'm mounting the munki repo from another volume.

#TODO
* add support for logging
