FROM markkimsal/php-platform:7.4.29-nginx-fpm

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

# NODEJS
RUN set -ex && \
    { \
        cd ~; \
        curl -sL https://deb.nodesource.com/setup_15.x -o nodesource_setup.sh; \
        bash ./nodesource_setup.sh; \
        apt update && apt-get install -y --no-install-recommends nodejs; \
    }

# YARN
RUN set -ex && \
    { \
     curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
     echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \
     apt update && apt-get install -y --no-install-recommends  yarn; \
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
RUN chown www-data /var/www;
WORKDIR /app
ENTRYPOINT []
CMD ["/bin/bash"]
