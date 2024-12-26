FROM ubuntu:focal

ENV TZ=Europe/Berlin
ENV RCFILE="--rcfile getmailrc"

ARG USER_ID=1000

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd -s /bin/bash getmail -u $USER_ID -b /data

RUN apt update -y && \
    apt upgrade -y
RUN apt install -y \
    getmail \
    gettext-base

WORKDIR /data

COPY getmailrc-template /getmailrc-template
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

