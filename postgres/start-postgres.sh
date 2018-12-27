#!/bin/bash

RUN_AS_USER_NAME=${1:-postgres}
RUN_AS_USER=$(id -u $RUN_AS_USER_NAME):$(id -g $RUN_AS_USER_NAME)

FUSE_MOUNT=/tmp/fuse_postgres

PSQL_HOME=$FUSE_MOUNT/postgresql
PSQL_DATA=$PSQL_HOME/data

if [ ! -d $PSQL_HOME ]; then
    mkdir -p $PSQL_DATA
    chmod -R o+rwx $PSQL_HOME
fi

sudo chown -R $RUN_AS_USER $PSQL_DATA

docker run \
--detach \
--restart=no \
--user $RUN_AS_USER \
--name v3io-postgres \
-p 5432:5432 \
-e PGDATA=/var/lib/postgresql/data \
--volume $PSQL_DATA:/var/lib/postgresql/data \
iguazio/postgres

if [ $? -eq 0 ]; then
    echo
    echo "PostgreSQL server is running in Docker as $RUN_AS_USER and stores the data files at $PSQL_DATA"
    echo Done.
fi
