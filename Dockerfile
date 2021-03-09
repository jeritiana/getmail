FROM ubuntu:focal

ENV TZ=Europe/Berlin
ENV RCFILE="--rcfile getmailrc"

ARG USER_ID=1000

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd -s /bin/bash getmail -u $USER_ID -b /data

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y getmail

RUN mkdir -p /data/mail && \
    mkdir /data/config && \
    chown $USER_ID -R /data

USER getmail

WORKDIR /data

CMD ["sh", "-c", "/usr/bin/getmail -v -n --getmaildir=/data/config $RCFILE"]