FROM php:7
RUN apt-get update -y && apt-get install -y openssl zip unzip git
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo pdo_mysql
WORKDIR /app
COPY . /app
RUN composer install
CMD composer update
CMD php artisan vendor:publish --provider="jeremykenedy\LaravelRoles\RolesServiceProvider" --tag=config
CMD php artisan vendor:publish --provider="jeremykenedy\LaravelRoles\RolesServiceProvider" --tag=migrations
CMD php artisan vendor:publish --provider="jeremykenedy\LaravelRoles\RolesServiceProvider" --tag=seeds
CMD chmod -R 755 ../laravel-auth
CMD php artisan key:generate
CMD composer dump-autoload
CMD npm install
CMD npm run watch

EXPOSE 8181
