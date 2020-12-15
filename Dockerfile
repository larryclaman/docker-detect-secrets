FROM python:3.7-slim

ARG BUILD_DATE

LABEL maintainer="Liran Tal <liran@snyk.io>"
LABEL securitytxt="https://github.com/lirantal/docker-detect-secrets/blob/master/security.txt"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="docker-secrets"
LABEL org.label-schema.description="A docker image for Yelp's docker-secrets python application"
LABEL org.label-schema.vcs-url="https://github.com/lirantal/docker-detect-secrets"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.docker.cmd="docker run -it --rm --name detect-secrets --volume `pwd`:/usr/src/app lirantal/detect-secrets 'src/component.js'"

RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*
RUN pip install detect-secrets
#
# Install azure plugin
COPY azure_storage_key.py /usr/local/lib/python3.7/site-packages/detect_secrets/plugins/azure_storage_key.py

ENTRYPOINT ["detect-secrets-hook", "--verbose"]