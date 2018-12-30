#!/bin/bash

set -e

DOCKER_IMAGE=iguazio/mariadb
CONTAINER_NAME=v3io-mysql

RUN_AS_USER=${1:-mysql}
RUN_AS_GROUP=$RUN_AS_USER
RUN_AS=$(id -u $RUN_AS_USER):$(id -g $RUN_AS_GROUP)

LOCAL_FS_MOUNT=/tmp/mariadb/mysql
rm -rf $LOCAL_FS_MOUNT
mkdir -p $LOCAL_FS_MOUNT

chmod -R 777 $LOCAL_FS_MOUNT
sudo chown $RUN_AS $LOCAL_FS_MOUNT

echo "Starting docker container $CONTAINER_NAME from image $DOCKER_IMAGE ..."
docker run \
--detach \
--restart=no \
--user $RUN_AS \
--name $CONTAINER_NAME \
-p 13306:3306 \
-e MYSQL_ALLOW_EMPTY_PASSWORD="true" \
--volume $LOCAL_FS_MOUNT:/var/lib/mysql \
$DOCKER_IMAGE

if [ $? -eq 0 ]; then
    echo
    echo "MySQL (MariaDB) server is running in Docker as $RUN_AS_USER and stores the data files at $LOCAL_FS_MOUNT"
    echo Done.
fi
