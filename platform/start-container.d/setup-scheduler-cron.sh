#!/usr/bin/env bash
set -e

ENV_FILE="/etc/container_environment.sh"
ENV_DIR="/etc/container_environment/"
source $ENV_FILE
WORK_DIR=${LARAVEL_QUEUE_WORK_DIR:-"/app"}
COMMAND="/usr/local/bin/php artisan schedule:run"

if ! [ -v ENABLE_ARTISAN_SCHEDULE ]; then
    echo "ENABLE_ARTISAN_SCHEDULE is NOT set, exiting with error code ..."
    exit 1
fi

if [ "${ENABLE_ARTISAN_SCHEDULE}" = "0" ]; then
    echo "ENABLE_ARTISAN_SCHEDULE is set to 0, skipping ..."
    exit 0
fi


echo "ENABLE_ARTISAN_SCHEDULE is set, writing /etc/cron.d/laravel-artisan-schedule-run ..."
echo "* * * * * www-data cd $WORK_DIR && $COMMAND >> /dev/null 2>&1" > /etc/cron.d/laravel-artisan-schedule-run
