FROM php:5.6-alpine

RUN apk add --no-cache gettext

RUN mkdir -p /var/app
RUN docker-php-ext-install mysql

COPY xaseco /var/app
COPY entrypoint.sh /var/app/

WORKDIR /var/app

ENTRYPOINT ./entrypoint.sh

CMD ["php", "aseco.php"] 
