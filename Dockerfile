FROM composer as build

COPY composer.* /app/
WORKDIR /app
RUN composer install

COPY . /app/

FROM php:8.3.0alpha1-cli-alpine3.18
COPY --from=build /app /app
RUN chown -R www-data /app/

USER www-data
EXPOSE 8080
WORKDIR /app/www

CMD export | cut -d' ' -f2- > /app/include/.env && php -S 0.0.0.0:8080
