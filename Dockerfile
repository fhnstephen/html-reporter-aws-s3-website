FROM python:latest

LABEL "com.github.actions.name"="Playwright HTML Reporter AWS S3 Upload"
LABEL "com.github.actions.description"="Upload Playwright HTML Test Results to an AWS S3 repository"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

LABEL version="0.1"
LABEL repository="https://github.com/PavanMudigonda/playwright-html-reporter-s3-website"
LABEL homepage="https://abcd.guru/"
LABEL maintainer="Pavan Mudigonda <mnpawan@gmail.com>"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='2.9.13'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

RUN apk update && \
    apk add --no-cache bash wget unzip && \
    rm -rf /var/cache/apk/*

ENV ROOT=/app

RUN mkdir -p $ROOT

WORKDIR $ROOT

COPY ./entrypoint.sh /entrypoint.sh

COPY ./pr-comment.py /pr-comment.py
COPY ./favicon.ico /favicon.ico
COPY ./logo.png /logo.png

RUN pip install PyGithub

RUN ["chmod", "+x", "/entrypoint.sh"]
RUN ["chmod", "+x", "/pr-comment.py"]

ENTRYPOINT ["/entrypoint.sh"]
