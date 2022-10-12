#!/bin/bash

if [ $# -eq 0 ]; then
    echo "must include major version ";
    exit 1;
fi

if [ "$1" == "7.3" ]; then
    VERSION="7.3.33";
    MAJORVERSION="7.3"
    FLAVOR="${FLAVOR:-nginx-fpm}"
fi
if [ "$1" == "7.4" ]; then
    VERSION="7.4.29";
    MAJORVERSION="7.4"
    FLAVOR="${FLAVOR:-nginx-fpm}"
fi
if [ "$1" == "8.0" ]; then
    VERSION="8.0.23";
    MAJORVERSION="8.0"
    FLAVOR="${FLAVOR:-nginx-fpm}"
fi
if [ "$1" == "8.1" ]; then
    VERSION="8.1.11";
    MAJORVERSION="8.1"
    FLAVOR="${FLAVOR:-nginx-fpm}"
fi


docker build -t markkimsal/php-platform:$VERSION-$FLAVOR -f $MAJORVERSION/$FLAVOR/Dockerfile .
echo "tagging markkimsal/php-platform:$VERSION-$FLAVOR as markkimsal/php-platform:$MAJORVERSION-$FLAVOR"
docker tag markkimsal/php-platform:$VERSION-$FLAVOR markkimsal/php-platform:$MAJORVERSION-$FLAVOR
