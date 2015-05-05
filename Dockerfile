FROM django:python2

ENV TIME_ZONE America/New_York
ENV APPNAME MunkiWebAdmin
ENV MUNKI_REPO_DIR /munki_repo
ENV MANIFEST_USERNAME_KEY user
ENV MANIFEST_USERNAME_IS_EDITABLE False
ENV WARRANTY_LOOKUP_ENABLED False
ENV MODEL_LOOKUP_ENABLED False

COPY ./munkiwebadmin /usr/src/app
COPY .docker/ /usr/sbin/

ENTRYPOINT ["/bin/bash", "/usr/sbin/run.sh"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
