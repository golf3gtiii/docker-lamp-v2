FROM php:5.6-apache

RUN apt-get update \
	&& apt-get install -y \
		apt-utils  \
		dialog \
    && apt-get install -y \
        libicu-dev \
        zlib1g-dev \
        php5-xdebug \
    && apt-get install -y ssmtp \
    && docker-php-ext-install \
        intl \
        mbstring \
        mysqli \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

RUN apt-get update && apt-get -y install php5-xdebug

RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

RUN a2enmod rewrite
RUN service apache2 restart
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data
