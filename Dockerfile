#== использую роки линукс, потому что по ТЗ нужно RPM based дистрибутив ==
FROM rockylinux:9

#== установка всех необходимых зависимостей (и дополнительных, например net-tools) ==
RUN dnf -y update && \
    dnf -y install epel-release && \
    dnf -y install \
        nginx \
        php \
        php-fpm \
        php-mysqlnd \
        mariadb-server \
        procps && \
    dnf clean all

#== настройка PHP-FPM ==
RUN sed -i 's/^listen = .*/listen = 127.0.0.1:9000/' /etc/php-fpm.d/www.conf
RUN mkdir -p /run/php-fpm

#== копирование всех файлов проекта ==
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.php /var/www/html/index.php
COPY init.sql /init.sql
COPY init.sh /init.sh

#== для безопасности ready-only файловая система
RUN chmod -R 755 /var/www/html && \
    chmod 644 /var/www/html/index.php

#== строчка, чтобы init.sh был исполняемым ==
RUN chmod +x /init.sh

#== открываем порт 80 веб сервера ==
EXPOSE 80

#== указываем скрипт как точку входа ==
CMD ["/init.sh"]