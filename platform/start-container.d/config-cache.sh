#!/usr/bin/env bash
set -ex

ENV_FILE="/etc/container_environment.sh"
ENV_DIR="/etc/container_environment/"
source $ENV_FILE
COMMAND="/usr/local/bin/php ./artisan config:cache"
WORK_DIR=${LARAVEL_HORIZON_WORK_DIR:-"/app"}

if [ -v SKIP_CONFIG_CACHE ]; then
    echo "SKIP_CONFIG_CACHE is set, skipping ..."
    sv down horizon
    exit 0
fi

cd $WORK_DIR
if [ ! -f artisan ];
then
    echo "No artisan found under $WORK_DIR skipping artisan config:cache ..."
    exit 0
fi

chpst -u www-data:www-data -e $ENV_DIR $COMMAND
