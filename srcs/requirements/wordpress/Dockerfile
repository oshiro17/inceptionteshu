FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-xml \
    php7.4-zip \
    wget \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

RUN mkdir -p /var/www/html/

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress /var/www/html/

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

COPY tools/wp-config-create.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-config-create.sh

RUN chown -R www-data:www-data /var/www/html/wordpress

EXPOSE 9000

CMD ["sh", "-c", "/usr/local/bin/wp-config-create.sh && php-fpm7.4 -F"]
