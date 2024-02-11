#!/bin/bash
clear
cat << __SPLASH__
################################################################################
#          42 42* 42  dP""*g 424242 42""Y* 424242 42  dP"Y*  42* 42            #
#          42 42Y*42 dP    " 42__   42__dP   42   42 dP   Y* 42Y*42            #
#          42 42 Y42 Y*      42""   42"""    42   42 Y*   dP 42 Y42            #
#          42 42  Y4  Y*oodP 424242 42       42   42  Y*odP  42  Y4            #
################################################################################
__SPLASH__

# Gather needed variables
echo "Website information:"
read -p "	Title: " TITLE
read -p "	Domain: " DOMAIN

echo "Database info:"
WP_DB_HOST=c-mariadb:3306
echo "	Database host: " ${WP_DB_HOST}
read -p "	Database name: " WP_DB_NAME
read -p "	Database user: " WP_DB_USER

echo "Wordpress credentials:"
read -p "	Admin: " WP_ADMIN
read -p "	Admin email: " WP_ADMIN_EMAIL
read -p "	Wordpress user: " WP_USER
read -p "	User email: " WP_USER_EMAIL
read -p "	Wordpress theme (optional): " WP_THEME

read -p "Specify tag for penultimate version of Alpine Linux: " PENULTIMATE

# Store data in .env files
echo "TITLE=${TITLE}" > srcs/wp.env
echo "DOMAIN=${DOMAIN}" >> srcs/wp.env
echo "WP_DB_HOST=${WP_DB_HOST}" >> srcs/wp.env
echo "WP_ADMIN=${WP_ADMIN:?'WP_ADMIN not set'}" >> srcs/wp.env
echo "WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}" >> srcs/wp.env
echo "WP_USER=${WP_USER:?'WP_USER not set'}" >> srcs/wp.env
echo "WP_USER_EMAIL=${WP_USER_EMAIL}" >> srcs/wp.env
echo "WP_THEME=${WP_THEME:=twentytwentyfour}" >> srcs/wp.env

echo "WP_DB_NAME=${WP_DB_NAME:=wordpress}" > srcs/mariadb.env
echo "WP_DB_USER=${WP_DB_USER:=wpuser}" >> srcs/mariadb.env

echo "# COMPOSE VARS" > srcs/.env
echo "ALPINE_VERSION=${PENULTIMATE:?'Alpine version not set'}" >> srcs/.env
echo "DATADIR=${HOME}/data" >> srcs/.env

# Auto generate strong passwords for wordpress
echo "Generating wordpress passwords..."
echo -n "WP_DB_PASSWORD=" >> srcs/.env
openssl rand -base64 32 | tr -d '=+/' | cut -c1-24 >> srcs/.env
echo -n "WP_ADMIN_PASSWORD=" >> srcs/.env
openssl rand -base64 32 | tr -d '=+/' | cut -c1-24 >> srcs/.env
echo -n "WP_USER_PASSWORD=" >> srcs/.env
openssl rand -base64 32 | tr -d '=+/' | cut -c1-24 >> srcs/.env

# Create SSL certificate and key
echo "Generating SSL certificate..."
&>/dev/null openssl req -x509 -newkey rsa:2048 -sha256 -days 365 -nodes \
	-keyout "${HOME}/data/ssl/site.key" \
	-out "${HOME}/data/ssl/site.crt" \
	-subj "/C=DE/L=Berlin/O=42Berlin/OU=student/CN=${DOMAIN}" \
	-addext "subjectAltName=DNS:${DOMAIN},DNS:\*.${DOMAIN}" || exit 1
echo "SSL certificate stored in ${HOME}/data/ssl/"

echo "Your LEMP stack is ready to be deployed"
echo "Bon voyage!"
