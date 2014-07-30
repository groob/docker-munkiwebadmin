# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-full:0.9.11

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV APP_DIR /home/app/munkiwebadmin

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Install python
RUN apt-get update && apt-get install -y \
  python-pip \
  python-dev \
  libpq-dev

RUN git clone https://code.google.com/p/munki.munkiwebadmin/ $APP_DIR

RUN mkdir -p /etc/my_init.d
ADD .docker/run.sh /etc/my_init.d/run.sh
ADD django/settings.py $APP_DIR/
ADD django/passenger_wsgi.py $APP_DIR/
ADD django/requirements.txt $APP_DIR/
RUN pip install -r $APP_DIR/requirements.txt
ADD nginx/nginx-env.conf /etc/nginx/main.d/
ADD nginx/munkiwebadmin.conf /etc/nginx/sites-enabled/munkiwebadmin.conf

VOLUME /munki_repo
EXPOSE 80

RUN rm -f /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
