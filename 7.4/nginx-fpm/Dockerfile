FROM php:7.4.29-fpm-bullseye as php-bullseye-build

RUN apt-get update;
	#apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold";

# MYSQL
RUN docker-php-ext-install pdo pdo_mysql mysqli;

# BC MATH
RUN docker-php-ext-install bcmath;

# PCNTL
RUN docker-php-ext-install pcntl;

# OPCACHE
RUN docker-php-ext-enable opcache;

# GD
RUN set -eux; \
	apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libwebp-dev \
	&& \
	docker-php-ext-configure gd \
		--with-freetype \
		--with-jpeg \
		--with-webp \
	&& \
	docker-php-ext-install gd;

# PGSQL
RUN set -eux; \
	apt-get install -y libpq-dev; \
	docker-php-ext-install pdo_pgsql

# MEMCACHE
RUN set -eux \
	&& { \
		apt-get install -y libmemcached-dev; \
		pecl install igbinary && \
		pecl install --nobuild memcached && \
		cd "$(pecl config-get temp_dir)/memcached" && \
		phpize && \
		./configure --enable-memcached-igbinary && \
		make -j$(nproc) && \
		make install; \
	    docker-php-ext-enable igbinary memcached; \
	}

# INTL
RUN set -ex \
    && { \
            apt-get install -y zlib1g-dev libicu-dev; \
			docker-php-ext-configure intl; \
			docker-php-ext-install intl; \
       }


# XDEBUG
RUN set -ex && \
    { \
            pecl install xdebug; \
    }

# XML
RUN set -ex \
    && { \
        apt-get install -y libxml2-dev; \
        docker-php-ext-install soap; \
    }

# ZIP
RUN set -ex \
    && { \
        apt-get install -y libzip-dev libzip4; \
        docker-php-ext-configure zip; \
        docker-php-ext-install zip; \
    }

# SSH
RUN set -ex \
    && { \
            apt-get install -y libssl-dev libssh2-1-dev git; \
            pecl install ssh2-1.3.1; \
            docker-php-ext-enable ssh2; \
       }

# LIBSODIUM
RUN set -ex \
    && { \
        apt-get install -y libsodium-dev libsodium23; \
        pecl install libsodium; \
        docker-php-ext-enable sodium; \
   }

# TIMEZONEDB
RUN set -ex && \
    { \
            pecl install timezonedb; \
            docker-php-ext-enable timezonedb; \
    }

# REDIS
RUN set -eux \
    && { \
        pecl install redis; \
        docker-php-ext-enable redis; \
    }


FROM debian:bullseye-slim

COPY --from=php-bullseye-build \
                /usr/local/ /usr/local/

COPY platform /platform

RUN /platform/build-deps.sh
RUN /platform/build-configs.sh
RUN /platform/install-bin.sh


COPY platform/runit-services /platform/services/
COPY platform/start-container /usr/local/bin/start-container

ENV SVDIR "/platform/services/"
ENV SVWAIT "60"
WORKDIR /app
EXPOSE 8080/tcp
EXPOSE 9000/tcp
ENTRYPOINT ["/usr/local/bin/start-container"]
