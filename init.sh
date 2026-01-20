#!/bin/bash
set -e

#== инициализация БД при первом запуске ==
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null 2>&1
fi

#== запуск БД в фоне ==
mysqld --user=mysql --datadir='/var/lib/mysql' > /dev/null 2>&1 &

#== ожидание запуска БД ==
for i in {1..30}; do
    if mysqladmin ping --silent 2>/dev/null; then
        break
    fi
    if [ $i -eq 30 ]; then
        exit 1
    fi
    sleep 1
done

#== инициализация создания таблиц и данных в БД ==
mysql < /init.sql 2>/dev/null

#== запуск PHP-FPM
php-fpm > /dev/null 2>&1 &

#== запуск nginx ==
exec nginx -g 'daemon off;'