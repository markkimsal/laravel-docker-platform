#!/usr/bin/env bash


mkdir -p /etc/container_environment/
echo '/platform/services/' > /etc/container_environment/SVDIR
echo '60' > /etc/container_environment/SVWAIT

mkdir -p /var/log/php-fpm
cp /platform/configs/container-nginx.vhost.conf /etc/nginx/conf.d/container-vhost.conf

cp /platform/configs/usr-local-etc-php-fpm-d-zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
