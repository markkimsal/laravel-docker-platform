FROM php:7.3.33-fpm-bullseye as php-bullseye-build

RUN docker-php-ext-install pdo pdo_mysql mysqli

#RUN set -ex \
#    && { \
#			apt-get update ; \
#            apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev; \
#            rm -rf /var/lib/apt/lists/*; \
#       }

#RUN docker-php-ext-configure gd \
#        --with-freetype-dir=/usr/include/freetype2 \
#        --with-png-dir=/usr/include \
#        --with-jpeg-dir=/usr/include

#RUN docker-php-ext-install gd \
#    && docker-php-ext-enable opcache

#RUN set -ex \
#    && { \
#            apt-get update ; \
#            apt-get install -y libmemcached-dev; \
#            rm -rf /var/lib/apt/lists/*; \
#       }

#RUN set -ex && \
#    { \
#            pecl install igbinary && \
#            pecl install --nobuild memcached && \
#            cd "$(pecl config-get temp_dir)/memcached" && \
#            phpize && \
#            ./configure --enable-memcached-igbinary && \
#            make -j$(nproc) && \
#            make install; \
#    } && \
#    docker-php-ext-enable igbinary memcached

#RUN set -ex \
#    && { \
#            apt-get update ; \
#            apt-get install -y zlib1g-dev libicu-dev; \
#            rm -rf /var/lib/apt/lists/*; \
##       }

#RUN docker-php-ext-configure intl \
#    && docker-php-ext-install intl

RUN set -ex && \
    { \
            pecl install xdebug; \
    }

# XML
#RUN set -ex \
#    && { \
#        apt-get update ; \
#        apt-get install -y libxml2-dev; \
#        rm -rf /var/lib/apt/lists/*; \
#        docker-php-ext-install soap; \
#    }

# ZIP
#RUN set -ex \
#    && { \
#        apt-get update ; \
#        apt-get install -y libzip-dev libzip4; \
#        docker-php-ext-configure zip --with-zlib-dir=/usr; \
#        docker-php-ext-install zip; \
#        docker-php-ext-enable zip; \
#    }

# SSH
#RUN set -ex \
#    && { \
#            apt-get update ; \
#            apt-get install -y libssl-dev libssh2-1-dev git; \
#            rm -rf /var/lib/apt/lists/*; \
#            pecl install ssh2-1.3.1; \
#            docker-php-ext-enable ssh2; \
#       }

# BC MATH
RUN docker-php-ext-install bcmath;

# PCNTL
RUN docker-php-ext-install pcntl

# LIBSODIUM
RUN set -ex \
    && { \
        apt-get update ; \
        apt-get install -y libsodium-dev libsodium23; \
        rm -rf /var/lib/apt/lists/*; \
        pecl install libsodium; \
        docker-php-ext-enable sodium; \
   }

# TIMEZONEDB
RUN set -ex && \
    { \
            pecl install timezonedb; \
            docker-php-ext-enable timezonedb; \
    }


FROM debian:bullseye-slim
COPY --from=php-bullseye-build \
                /usr/local/ /usr/local/

COPY --from=php-bullseye-build \
                /usr/lib/x86_64-linux-gnu/libargon*.so.1   \
                /usr/lib/x86_64-linux-gnu/libicu*.so.63    \
                /usr/lib/x86_64-linux-gnu/libsql*.so.0     \
                /usr/lib/x86_64-linux-gnu/libpng*.so       \
                /usr/lib/x86_64-linux-gnu/libjpeg*.so      \
                /usr/lib/x86_64-linux-gnu/libfreet*.so     \
                /usr/lib/x86_64-linux-gnu/libmemcached*.so \
                /usr/lib/x86_64-linux-gnu/

RUN ldconfig

COPY platform /platform

RUN /platform/build-deps.sh
RUN    /platform/build-configs.sh
RUN    /platform/install-bin.sh


COPY platform/runit-services /platform/services/
COPY platform/start-container /usr/local/bin/start-container

ENV SVDIR "/platform/services/"
ENV SVWAIT "60"
WORKDIR /app
EXPOSE 8080/tcp
EXPOSE 9000/tcp
CMD ["/usr/local/bin/start-container"]