FROM alpine:3.1

ENV TIME_ZONE America/New_York
ENV APPNAME MunkiWebAdmin
ENV MUNKI_REPO_DIR /munki_repo
ENV MANIFEST_USERNAME_KEY user
ENV MANIFEST_USERNAME_IS_EDITABLE False
ENV WARRANTY_LOOKUP_ENABLED False
ENV MODEL_LOOKUP_ENABLED False

WORKDIR /munkiwebadmin
COPY . /munkiwebadmin

RUN apk add --update python py-pip
RUN apk --update add --virtual build-dependencies python-dev build-base wget postgresql libpq postgresql-contrib postgresql-dev \
  && pip install -r requirements.txt \
  && apk del build-dependencies
