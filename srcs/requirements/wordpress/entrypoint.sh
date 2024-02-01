#!/bin/sh

if [ ! -f wp-config-sample.php ]; then
	wp core download --skip-content
fi

if [ ! -f wp-config.php ]; then
	wp config create \
		--dbname=${WP_DB_NAME} \
		--dbuser=${WP_DB_USER} \
		--dbhost=${WP_DB_HOST} \
		--prompt=dbpass < /run/secrets/wp_db_password

	wp core install --url=${DOMAIN} --title="${TITLE}" \
		--admin_user="${WP_ADMIN}" \
		--admin_email="${WP_ADMIN_EMAIL}" --skip-email \
		--prompt=admin_password < /run/secrets/wp_admin_password

	wp user create "${WP_USER}" "${WP_USER_EMAIL}" --role="editor" \
		--prompt=user_pass < /run/secrets/wp_user_password

	wp theme install ${WP_THEME:=twentytwentythree} --activate

	wp config set WP_REDIS_HOST c-redis
	wp config set WP_REDIS_PORT 6379

	# wp plugin update --all
	wp plugin install redis-cache --activate
	wp redis enable
fi

exec "$@"
