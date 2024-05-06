FROM debian:bullseye

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/init.sh /init.sh
COPY ./conf/mariadb-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /init.sh

CMD ["/init.sh"]
