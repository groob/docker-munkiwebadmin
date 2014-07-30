#!/bin/bash
APP_DIR=/home/app/munkiwebadmin
cd $APP_DIR
python manage.py syncdb --noinput
python manage.py migrate --noinput
# cd /home/app/munkiwebadmin && \
#    python manage.py syncdb --all --noinput && \
#    python manage.py migrate --fake && \
#    python manage.py collectstatic --noinput
