FROM composer as build

COPY composer.* /app/
WORKDIR /app
RUN composer install

COPY . /app/

FROM php:8.5.2RC1-cli-alpine3.23
COPY --from=build /app /app
RUN chown -R www-data /app/

USER www-data
EXPOSE 8080
WORKDIR /app/www

CMD export | cut -d' ' -f2- > /app/include/.env && php -S 0.0.0.0:8080
