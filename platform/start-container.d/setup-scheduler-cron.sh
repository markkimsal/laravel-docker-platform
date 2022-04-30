#!/usr/bin/env bash
set -ex

ENV_FILE="/etc/container_environment.sh"
ENV_DIR="/etc/container_environment/"
source $ENV_FILE
COMMAND="/usr/local/bin/php artisan horizon"
WORK_DIR=${LARAVEL_HORIZON_WORK_DIR:-"/app"}

echo "* * * * * www-data cd $WORK_DIR && /usr/local/bin/php ./artisan schedule:run >> /dev/null 2>&1" > /etc/cron.d/laravel-artisan-schedule-run
