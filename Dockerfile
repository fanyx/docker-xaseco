FROM php:5.6-alpine

RUN apk add --no-cache gettext

RUN docker-php-ext-install mysql

COPY xaseco /app

WORKDIR /app

ENTRYPOINT ./entrypoint.sh

CMD ["php", "aseco.php"] 
