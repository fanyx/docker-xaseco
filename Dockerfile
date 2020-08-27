FROM php:5.6-alpine

RUN apk add --no-cache gettext bash

RUN docker-php-ext-install mysql

COPY xaseco /app
COPY entrypoint.sh /app/
COPY scripts/* /app/

WORKDIR /app

ENTRYPOINT ["./entrypoint.sh"]

CMD ["php", "aseco.php"] 
