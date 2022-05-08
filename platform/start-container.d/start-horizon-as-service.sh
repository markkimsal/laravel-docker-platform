#!/usr/bin/env bash
set -ex

ENV_FILE="/etc/container_environment.sh"
ENV_DIR="/etc/container_environment/"
source $ENV_FILE

if [ ! -v START_HORIZON_AS_SERVICE ]; then
    if [ -d /platform/services/horizon ]; then
        mv /platform/services/horizon /platform/horizon-svc-off
    fi
fi
