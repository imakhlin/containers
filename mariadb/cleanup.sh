#!/bin/bash

CONTAINER_NAME=v3io-mysql
LOCAL_MYSQL_DIR=/tmp/mysql
FUSE_MYSQL_DIR=/tmp/fuse_mysql/mysql/data

echo "Stopping $CONTAINER_NAME docker container..."
docker stop $CONTAINER_NAME

echo "Removing $CONTAINER_NAME docker container..."
docker rm $CONTAINER_NAME

if [ -d $LOCAL_MYSQL_DIR ]; then
  echo "Removing conetent of the mysql local data directory ($LOCAL_MYSQL_DIR) ..."
  rm -rf $LOCAL_MYSQL_DIR
fi

if [ -d $FUSE_MYSQL_DIR ]; then
  echo "Removing content of the mysql data directory on fuse mount ($FUSE_MYSQL_DIR) ..."
  sudo rm -rf $FUSE_MYSQL_DIR/*
fi

echo Done.
