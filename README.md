# Inception

When one container is not enough  
Downward is the only way forward.

## LEMP++ stack

Docker composition of containers hosting a Wordpress website, a static website, 
a MariaDB instance handling databases, Adminer as database management tool, Redis 
cache integrated with wordpress, an FTPS server linked with wordpress data. And 
as a cherry on top, a container hosting Gitea instance on which this repo can be 
pushed to complete the cycle of Inception.  
All Docker images are custom built, based on Alpine Linux (as per subject requirements).

## Usage

This project is intended to run within a Virtual Machine of choice and preset 
according to individual preferences. Requires at minimum sudo, docker compose, 
FTPS client and a web browser.  
For best experience, edit **/etc/hosts** file and add following domains on localhost:

```
{intra}.42.fr
static.{intra}.42.fr
admin.{intra}.42.fr
gitea.{intra}.42.fr
```

FTP can be accessed at port 4221  

Run a setup script that guides through providing all the necessary and optional data:

```
make init
```
  
It also creates strong passwords for access to services, available in **srcs/.env** file  

When ready, build and spin up all the docker containers:

```
make up
```

For more information on the rest of the available commands:

```
make help
```

The first step to inception is inception itself.  
