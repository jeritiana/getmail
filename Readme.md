# Getmail Docker Container

Since Fedora no longer ships with software that depends on Python 2.7 and `getmail` has not yet been updated to Python 3 this container can be used instead.

## Build Container

Download the `Dockerfile` and build the container locally:

```bash
podman build -t getmail:focal -f Dockerfile
```

## Pull Container

You can also pull it from quay.io:

```bash
podman pull quay.io/ckoenig/getmail
```

## Create or Update getmailrc

```
...
[destination]
type = Maildir
path = /data/mail/
...
[options]
message_log = /data/mail/log
...
```

## Run Container

```bash
podman run -it \
  --rm \
  --userns keep-id \
  -v ~/.getmail:/mail/config:Z \
  -v ~/mail:/data/mail:Z \
  getmail:focal
```