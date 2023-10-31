#! /bin/sh

chown -R mysql: /var/lib/mysql
chmod 777 /var/lib/mysql

mysql_install_db >/dev/null 2>&1

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
  rm -f "$MYSQL_INIT_FILE"
  echo "CREATE DATABASE $MYSQL_DATABASE;" >> $MYSQL_INIT_FILE
  echo "CREATE USER $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $MYSQL_INIT_FILE
  echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO $MYSQL_USER@'%' WITH GRANT OPTION;" >> $MYSQL_INIT_FILE
  echo "FLUSH PRIVILEGES;" >> $MYSQL_INIT_FILE
  echo "DROP USER 'root'@'localhost';" >> $MYSQL_INIT_FILE
  echo "CREATE USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $MYSQL_INIT_FILE
  echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> $MYSQL_INIT_FILE
  echo "FLUSH PRIVILEGES;" >> $MYSQL_INIT_FILE
  mysqld_safe --init-file=$MYSQL_INIT_FILE >/dev/null 2>&1
else
  mysqld_safe >/dev/null 2>&1
fi
echo "Starting MariDB server..."