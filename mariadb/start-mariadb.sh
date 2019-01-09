#!/bin/bash

RUN_AS_USER_NAME=${1:-mysql}
RUN_AS_USER=$(id -u $RUN_AS_USER_NAME):$(id -g $RUN_AS_USER_NAME)

FUSE_MOUNT=/tmp/fuse_mysql

MYSQL_HOME=$FUSE_MOUNT/mysql

if [ ! -d $MYSQL_HOME ]; then
    mkdir -p $MYSQL_HOME
    chmod -R o+rwx $MYSQL_HOME
fi

sudo chown -R $RUN_AS_USER $MYSQL_HOME

docker run \
--detach \
--restart=no \
--user $RUN_AS_USER \
--name v3io-mysql \
-p 13306:3306 \
-e MYSQL_ALLOW_EMPTY_PASSWORD="true" \
--volume $MYSQL_HOME:/var/lib/mysql \
iguazio/mariadb

if [ $? -eq 0 ]; then
    echo
    echo "MySQL server is running in Docker as $RUN_AS_USER and stores the data files at $MYSQL_DATA"
    echo Done.
fi
