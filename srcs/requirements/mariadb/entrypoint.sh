#!/bin/sh

WP_DB_PASSWORD=`cat /run/secrets/wp_db_password`

cat << __instructions_end__ > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME ;
CREATE USER IF NOT EXISTS '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASSWORD' ;
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%' WITH GRANT OPTION ;
FLUSH PRIVILEGES ;
__instructions_end__

exec "$@"
