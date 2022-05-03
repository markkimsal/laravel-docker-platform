#!/usr/bin/env bash
set -ex

ENV_FILE="/etc/container_environment.sh"
ENV_DIR="/etc/container_environment/"
source $ENV_FILE
WORK_DIR=${LARAVEL_QUEUE_WORK_DIR:-"/app"}
COMMAND="/usr/local/bin/php artisan schedule:run"

echo "* * * * * www-data cd $WORK_DIR && $COMMAND >> /dev/null 2>&1" > /etc/cron.d/laravel-artisan-schedule-run
