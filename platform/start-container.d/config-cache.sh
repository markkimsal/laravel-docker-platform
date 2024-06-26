#!/usr/bin/env bash
set -e

ENV_FILE="/etc/container_environment.sh"
ENV_DIR="/etc/container_environment/"
source $ENV_FILE
COMMAND="/usr/local/bin/php ./artisan config:cache"
WORK_DIR=${LARAVEL_WORK_DIR:-"/app"}

if [ -v SKIP_CONFIG_CACHE ]; then
    echo "SKIP_CONFIG_CACHE is set, skipping ..."
    exit 0
fi

if ! [ -v ENABLE_CONFIG_CACHE ]; then
    echo "ENABLE_CONFIG_CACHE not set, skipping ..."
    exit 0
fi

cd $WORK_DIR
if [ ! -f artisan ];
then
    echo "No artisan found under $WORK_DIR skipping artisan config:cache ..."
    exit 0
fi

chpst -u www-data:www-data -e $ENV_DIR $COMMAND
