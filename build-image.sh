#!/bin/bash

if [ $# -eq 0 ]; then
    echo "must include major version ";
    exit 1;
fi

if [ "$1" == "7.3" ]; then
    VERSION="7.3.33";
	MAJORVERSION="7.3"
fi
if [ "$1" == "7.4" ]; then
    VERSION="7.4.28";
	MAJORVERSION="7.4"
fi
if [ "$1" == "8.0" ]; then
    VERSION="8.0.17";
	MAJORVERSION="8.0"
fi

docker build -t markkimsal/php-platform:$VERSION-nginx-fpm -f $MAJORVERSION/nginx-fpm/Dockerfile .
echo "tagging markkimsal/php-platform:$VERSION-nginx-fpm as markkimsal/php-platform:$MAJORVERSION-nginx-fpm"
docker tag markkimsal/php-platform:$VERSION-nginx-fpm markkimsal/php-platform:$MAJORVERSION-nginx-fpm
