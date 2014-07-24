munkiwebadmin-docker
==========

Dockerfile for munkiwebadmin

#Munki container
the settings should be configured during the DB step. The munkiwebadmin container uses the linked db container.
##build
In the folder with the Dockerfile, run

```docker build -t mwa .```
##run
```docker run -p 80:8080 -d --link mwa-postgresql:db mwa /sbin/my_init```

#PostgreSQL container

    docker run -d --name="mwa-postgresql" \
                 -p 127.0.0.1:5432:5432 \
                 -v /tmp/postgresql:/data \
                 -e USER="mwaadmin" \
                 -e DB="mwa_db" \
                 -e PASS="password" \
                 paintedfox/postgresql


#To Do

* Implement backup to S3
* set admin user and password from environment variables.

