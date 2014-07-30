#!/bin/sh

cd /home/app/munkiwebadmin && \
   python manage.py syncdb --all --noinput && \
   python manage.py migrate --fake && \
   python manage.py collectstatic --noinput
