#! /bin/sh

check_connection() {
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -e "SELECT 1;" 2>/dev/null
}


# install wordpress cli
if [ ! -f "/usr/local/bin/wp" ]; then
  echo "Installing WP-CLI."
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --silent
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
fi

# connect to db
while true; do
  echo "Trying to connect to MYSQL..."
  if check_connection >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

echo "Connection successful."

# Set up wordpress
if [ ! -f /wordpress/wp-config.php ]; then
  echo "Configuring WordPress."
  wp core download --path=/wordpress

  wp config create --path=/wordpress --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST

  wp core install --url=$DOMAIN_NAME --title=Inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email="$ADMIN_EMAIL" --path=/wordpress

  wp theme install --activate oceanwp --path=/wordpress

  wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_PASSWORD --path=/wordpress


  sed -i "94idefine('WP_CACHE', true);" /wordpress/wp-config.php
fi

php-fpm81 --nodaemonize