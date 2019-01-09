#!/bin/bash

set -e

DOCKER_IMAGE=iguazio/postgres
CONTAINER_NAME=v3io-postgres

#RUN_AS=$(id -u):$(id -g)
RUN_AS=postgres:postgres

LOCAL_FS_MOUNT=/tmp/postgres/data
rm -rf $LOCAL_FS_MOUNT
mkdir -p $LOCAL_FS_MOUNT

chmod -R 0750 $LOCAL_FS_MOUNT
sudo chown $RUN_AS $LOCAL_FS_MOUNT

echo "Starting docker container $CONTAINER_NAME from image $DOCKER_IMAGE ..."
docker run \
--detach \
--restart=no \
--user $RUN_AS \
--name $CONTAINER_NAME \
-p 5432:5432 \
-e PGDATA=/var/lib/postgresql/data \
--volume $LOCAL_FS_MOUNT:/var/lib/postgresql/data \
$DOCKER_IMAGE

if [ $? -eq 0 ]; then
    echo
    echo "PostgreSQL server is running in Docker as $RUN_AS_USER and stores the data files at $LOCAL_FS_MOUNT"
    echo Done.
fi
