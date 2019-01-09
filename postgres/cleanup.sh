#!/bin/bash

CONTAINER_NAME=v3io-postgres
LOCAL_PSQL_DIR=/tmp/psql
FUSE_PSQL_DIR=/tmp/fuse_postgres/postgresql/data

echo "Stopping $CONTAINER_NAME docker container..."
docker stop $CONTAINER_NAME

echo "Removing $CONTAINER_NAME docker container..."
docker rm $CONTAINER_NAME

if [ -d $LOCAL_PSQL_DIR ]; then
  echo "Removing conetent of the postgres local data directory ($LOCAL_PSQL_DIR) ..."
  rm -rf $LOCAL_PSQL_DIR
fi

if [ -d $FUSE_PSQL_DIR ]; then
  echo "Removing content of the postgres data directory on fuse mount ($FUSE_PSQL_DIR) ..."
  sudo rm -rf $FUSE_PSQL_DIR/*
fi

echo Done.
