#!/usr/bin/env bash
set -e

ENV_FILE="/etc/container_environment.sh"
ENV_DIR="/etc/container_environment/"
source $ENV_FILE
COMMAND="/usr/local/bin/php ./artisan config:cache"
WORK_DIR=${LARAVEL_WORK_DIR:-"/app"}

if ! [ -v ENABLE_CHANGE_OWNER ]; then
    echo "ENABLE_CHANGE_OWNER not set, skipping ..."
    exit 0
fi

if [ ! -z "$WWWUID" ]; then
    usermod -u $WWWUID www-data;
    chown www-data /app;
    chown -R www-data /app/storage;
    chown -R www-data /app/bootstrap;
    chown -R www-data /var/www;
fi

if [ ! -z "$WWWGID" ]; then
    groupmod -g $WWWGID www-data
    chgrp www-data /app;
    chgrp -R www-data /app/storage;
    chgrp -R www-data /app/bootstrap;
    chgrp -R www-data /var/www;
fi
