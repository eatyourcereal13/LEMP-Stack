#== использую роки линукс, потому что по ТЗ нужно RPM based дистрибутив ==
FROM rockylinux:9

#== установка всех необходимых зависимостей (и дополнительных, например procps) ==
#== dnf clean all - чищу кеш пакетов для уменьшения размера образа ==
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

#== настройка PHP-FPM: меняем сокет на TCP порт 9000 для соединения с Nginx ==
RUN sed -i 's/^listen = .*/listen = 127.0.0.1:9000/' /etc/php-fpm.d/www.conf

#== создаем директорию для PID файла PHP-FPM (без нее не запустится) ==
RUN mkdir -p /run/php-fpm

#== копирование всех файлов проекта ==
#== конфиг Nginx с метриками ==
COPY nginx.conf /etc/nginx/nginx.conf
#== главная страница на PHP ==
COPY index.php /var/www/html/index.php
#== SQL скрипт для инициализации БД ==
COPY init.sql /init.sql
#== скрипт запуска всех сервисов ==
COPY init.sh /init.sh

#== строчка, чтобы init.sh был исполняемым ==
RUN chmod +x /init.sh

#== порт 80 веб сервера ==
EXPOSE 80

#== указываем скрипт как точку входа ==
CMD ["/init.sh"]