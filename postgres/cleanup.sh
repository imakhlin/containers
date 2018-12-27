#!/bin/bash

CONTAINER_NAME=v3io-postgres
LOCAL_PSQL_DIR=/tmp/psql 
FUSE_PSQL_DIR=/tmp/fuse_postgres/postgresql/data

echo "Removing postgres local data from $LOCAL_PSQL_DIR ..."
rm -rf $LOCAL_PSQL_DIR

echo "Removing postgres data from fuse mount at $FUSE_PSQL_DIR ..."
sudo rm -rf $FUSE_PSQL_DIR/*

echo "Stopping $CONTAINER_NAME docker container..."
docker stop $CONTAINER_NAME

echo "Removing $CONTAINER_NAME docker container..."
docker rm $CONTAINER_NAME

echo Done.
