FROM ubuntu:focal

ENV TZ=Europe/Berlin

ARG USER_ID=1000

RUN useradd -s /bin/bash getmail -u $USER_ID -b /data

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y getmail

RUN mkdir -p /data/mail && \
    mkdir /data/config && \
    chown $USER_ID -R /data

USER getmail

WORKDIR /data

ENTRYPOINT ["/usr/bin/getmail"]
CMD ["-v", "-n", "--getmaildir=/data/config"]