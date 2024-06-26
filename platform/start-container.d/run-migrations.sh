#!/usr/bin/env bash
set -e

ENV_FILE="/etc/container_environment.sh"
ENV_DIR="/etc/container_environment/"
source $ENV_FILE
WORK_DIR=${LARAVEL_WORK_DIR:-"/app"}
COMMAND=${LARAVEL_MIGRATE_COMMAND:-"/usr/local/bin/php artisan migrate --force"}

if [ -v SKIP_MIGRATIONS ]; then
    echo "SKIP_MIGRATIONS is set, skipping ..."
    exit 0
fi
if ! [ -v ENABLE_MIGRATIONS ]; then
    echo "ENABLE_MIGRATIONS not set, skipping ..."
    exit 0
fi

cd $WORK_DIR
chpst -u www-data:www-data -e $ENV_DIR $COMMAND
