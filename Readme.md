[![Docker Repository on Quay](https://quay.io/repository/ckoenig/getmail/status "Docker Repository on Quay")](https://quay.io/repository/ckoenig/getmail)

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
  -v ~/.getmail:/data/config:Z \
  -v ~/mail:/data/mail:Z \
  quay.io/ckoenig/getmail
```

Or with Docker (and without SELinux specific flags):

```bash
docker run -it \
  --rm \
  -u 1000 \
  -v ~/.getmail:/data/config \
  -v ~/mail:/data/mail \
  quay.io/ckoenig/getmail
```
## Multiple accounts

`getmail` supports multiple accounts with multiple rc files by specifying each one with a `--rcfile $file` option. 
You can do the same by setting the `RCFILE` environment variable in your run command.
The files should be inside your mail directory. For example, if you have two rc files `getmailrc1` and `getmailrc2` (both inside `~/mail`),
use the following command:

```bash
docker run -it \
  --rm \
  -u 1000
  -v ~/.getmail:/data/config:Z \
  -v ~/mail:/data/mail:Z \
  -e RCFILE="--rcfile getmailrc1 --rcfile getmailrc2"
  quay.io/ckoenig/getmail
```

Or with podman:

```bash
podman run -it \
  --rm \
  --userns keep-id \
  -v ~/.getmail:/data/config:Z \
  -v ~/mail:/data/mail:Z \
  -e RCFILE="--rcfile getmailrc1 --rcfile getmailrc2"
  quay.io/ckoenig/getmail
```

Make sure that each rc file has its own mail directory if you don't want mails from multiple accounts to end up in the same directory:


### getmailrc1 example

```
[destination]
type = Maildir
path = /data/mail/rc1/
```

### getmailrc2 example

```
[destination]
type = Maildir
path = /data/mail/rc2/
```

Since `getmail` does not create the maildir directories you may need to create them before running the command above:

```bash
mkdir -p ~/mail/rc1/{new,cur,tmp}
mkdir -p ~/mail/rc2/{new,cur,tmp}
```