FROM alpine:3.1

ENV TIME_ZONE America/New_York
ENV APPNAME MunkiWebAdmin
ENV MUNKI_REPO_DIR /munki_repo
ENV MANIFEST_USERNAME_KEY user
ENV MANIFEST_USERNAME_IS_EDITABLE False
ENV WARRANTY_LOOKUP_ENABLED False
ENV MODEL_LOOKUP_ENABLED False

COPY requirements.txt /tmp/

RUN apk add --update python py-pip libpq
RUN apk --update add --virtual build-dependencies python-dev build-base wget postgresql postgresql-contrib postgresql-dev \
  && pip install -r /tmp/requirements.txt \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/*

COPY .docker/ /usr/sbin/
COPY ./munkiwebadmin /munkiwebadmin
COPY ./admin_tools /munkiwebadmin/admin_tools
COPY settings.py /munkiwebadmin/

WORKDIR /munkiwebadmin

ENTRYPOINT ["/bin/sh", "/usr/sbin/run.sh"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
