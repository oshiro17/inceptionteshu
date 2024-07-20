FROM debian:bullseye

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY conf/my.cnf /etc/mysql/my.cnf

RUN mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql

COPY tools/init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

EXPOSE 3306

CMD ["/bin/bash", "-c", "/docker-entrypoint-initdb.d/init.sh && exec mysqld"]