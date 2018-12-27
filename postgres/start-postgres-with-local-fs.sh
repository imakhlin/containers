#!/bin/bash

CONTAINER_NAME=iguazio/postgres
#RUN_AS_USER=$(id -u):$(id -g)
RUN_AS_USER=postgres:postgres

LOCAL_FS_MOUNT=/tmp/psql
rm -rf $LOCAL_FS_MOUNT
mkdir -p $LOCAL_FS_MOUNT

echo "Starting docker container $CONTAINER_NAME ..."
docker run \
--detach \
--restart=always \
--user $RUN_AS_USER \
--name v3io-postgres \
-p 5432:5432 \
-e PGDATA=/var/lib/postgresql/data_local \
--volume $LOCAL_FS_MOUNT:/var/lib/postgresql/data_local \
$CONTAINER_NAME

if [ $? -eq 0 ]; then
    echo
    echo "PostgreSQL server is running in Docker as $RUN_AS_USER and stores the data files at $LOCAL_FS_MOUNT"
    echo Done.
fi
