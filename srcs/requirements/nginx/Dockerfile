FROM debian:bullseye

RUN apt-get update -y \
&& apt-get upgrade -y \
&& apt-get -y install nginx openssl 

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
	-subj "/C=FR/ST=IDF/L=Angouleme/O=42/OU=42/CN=mafissie.42.fr/UID=mafissie"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html 
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]