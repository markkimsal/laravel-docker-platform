#!/usr/bin/env bash

set -e
source /platform/build-env
set -ex

apt-get update
## Install HTTPS support for APT.
#$minimal_apt_get_install apt-transport-https ca-certificates
## Install add-apt-repository
#$minimal_apt_get_install software-properties-common
## Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold"

$minimal_apt_get_install \
    runit           \
    nginx           \
    dumb-init       \
    ca-certificates \
    cron            \
    openssh-client  \
    psmisc          \
    procps

$minimal_apt_get_install \
    libsodium23   \
    libfreetype6  \
    libreadline8  \
    libcurl4      \
    libpqxx-6.4   \
    libonig5      \
    libssl1.1     \
    libssh2-1     \
    libxml2       \
    zlib1g        \
    libicu67      \
    libpng16-16   \
    libjpeg62     \
    libfreetype6  \
    libargon2-1   \
    libsqlite3-0  \
    libmemcached11 \
    libzip4


if [ $WITH_TENSOR -eq 1 ]; then
$minimal_apt_get_install \
	libopenblas0 \
	liblapacke;
fi

apt-get clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
