#! /bin/sh

chown -R mysql: /var/lib/mysql
chmod 777 /var/lib/mysql

mysql_install_db >/dev/null 2>&1

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
  rm -f "$MYSQL_INIT_FILE"
  echo "USE mysql;" >> $MYSQL_INIT_FILE
  echo "FLUSH PRIVILEGES;" >> $MYSQL_INIT_FILE
  echo "DELETE FROM	mysql.user WHERE User='';" >> $MYSQL_INIT_FILE
  echo "DROP DATABASE test;" >> $MYSQL_INIT_FILE
  echo "DELETE FROM mysql.db WHERE Db='test';" >> $MYSQL_INIT_FILE
  echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> $MYSQL_INIT_FILE
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $MYSQL_INIT_FILE
  echo "CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $MYSQL_INIT_FILE
  echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';" >> $MYSQL_INIT_FILE
  echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> $MYSQL_INIT_FILE
  echo "FLUSH PRIVILEGES;" >> $MYSQL_INIT_FILE
  mysqld_safe --init-file=$MYSQL_INIT_FILE >/dev/null 2>&1
else
  mysqld_safe >/dev/null 2>&1
fi
echo "Starting MariDB server..."