#!/bin/sh

# same as in Dockerfile
USER_ID=1000

# config dir
rm -rf /tmp/config
mkdir /tmp/config
envsubst < /getmailrc-template > /tmp/config/getmailrc
chown $USER_ID -R /tmp/config

# data dir
rm -rf /data/mail
mkdir /data/mail
touch /data/mail/$MAILBOX_USERNAME.mbox
chown $USER_ID -R /data

# retrieve emails
getmail --getmaildir=/tmp/config --rcfile getmailrc

