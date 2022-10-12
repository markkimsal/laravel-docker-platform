FROM markkimsal/php-platform:8.1.11-nginx-fpm

# CURL GIT UNZIP
RUN set -ex && \
    { \
        apt-get update ; \
        apt-get install -y --no-install-recommends curl unzip git-core jq; \
    }

# COMPOSER
RUN set -ex && \
    { \
        EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"; \
        php -r 'copy("https://getcomposer.org/installer", "composer-setup.php");'; \
        ACTUAL_CHECKSUM="$(php -r 'echo hash_file("sha384", "composer-setup.php");')"; \
        if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; \
        then \
            >&2 echo 'ERROR: Invalid installer checksum'; \
            rm composer-setup.php; \
            exit 1; \
        fi; \
        php composer-setup.php --quiet; \
        RESULT=$? \
        mv composer.phar /usr/local/bin/composer; \
        chmod a+x /usr/local/bin/composer; \
        php composer-setup.php -1 --quiet; \
        RESULT=$? \
        mv composer.phar /usr/local/bin/composer1.10; \
        chmod a+x /usr/local/bin/composer1.10; \
        rm composer-setup.php; \
    }

# GIT
RUN set -ex && \
    { \
        apt-get install -y --no-install-recommends git-core; \
    }



# DEPLOYER
RUN set -ex && \
    { \
        curl -LO https://deployer.org/deployer.phar; \
        mv deployer.phar /usr/local/bin/deployer; \
        chmod +x /usr/local/bin/deployer; \
        composer global require deployer/recipes --dev; \
        curl -L https://raw.githubusercontent.com/kohkimakimoto/altax/master/installer.sh | bash -s system; \
        apt-get install -y --no-install-recommends  openssh-client; \
    }

RUN rm -rf /var/lib/apt/lists/*;
WORKDIR /app
ENTRYPOINT []
CMD ["/bin/bash"]