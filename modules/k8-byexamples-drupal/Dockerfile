FROM php:7.2-apache

RUN apt-get update && \
    apt-get install -y \
    libssl-dev libcurl4-openssl-dev pkg-config \
    libpng-dev \
    libjpeg-dev \
    libpq-dev \
    libxml2-dev && \
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
	docker-php-ext-install gd mbstring pdo_mysql pdo_pgsql zip curl pcntl && \
	docker-php-ext-install opcache bcmath soap && \
	a2enmod rewrite && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir /app && rm /etc/apache2/sites-enabled/000-default.conf

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
    echo 'log_errors=1'; \
    echo 'error_log=/tmp/php_errors.log'; \
  } > /usr/local/etc/php/conf.d/errors.ini

RUN { \
    echo 'post_max_size=200M'; \
    echo 'upload_max_filesize=200M'; \
  } > /usr/local/etc/php/conf.d/file-uploads.ini

VOLUME ["/app"]

# Install composer and install global drush
RUN cd /tmp \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && mv composer.phar /usr/local/bin/composer \
  && unlink composer-setup.php \
  && composer global require webflo/drush-shim \
  && ln -s /root/.composer/vendor/webflo/drush-shim/bin/drush /usr/local/bin/drush

# Install Drupal console launcher
RUN curl https://drupalconsole.com/installer -L -o drupal.phar \
  && mv drupal.phar /usr/local/bin/drupal \
  && chmod +x /usr/local/bin/drupal

COPY ./docker/config/apache/dodpt-vhost.conf /etc/apache2/sites-enabled/000-dodpt-vhost.conf
COPY ./docker/aws.credentials /.aws/credentials