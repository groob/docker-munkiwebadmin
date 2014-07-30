# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-full:0.9.11

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Install python
RUN apt-get update && apt-get install -y \
  python-pip \
  python-dev \
  libpq-dev

RUN git clone https://code.google.com/p/munki.munkiwebadmin/ /home/app/munkiwebadmin

RUN mkdir -p /etc/my_init.d
ADD run.sh /etc/my_init.d/run.sh
ADD settings.py /home/app/munkiwebadmin/
ADD passenger_wsgi.py /home/app/munkiwebadmin/
ADD requirements.txt /home/app/munkiwebadmin/
RUN pip install -r /home/app/munkiwebadmin/requirements.txt
ADD nginx-env.conf /etc/nginx/main.d/
ADD munkiwebadmin.conf /etc/nginx/sites-enabled/munkiwebadmin.conf

VOLUME /munki_repo
EXPOSE 80

RUN rm -f /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
