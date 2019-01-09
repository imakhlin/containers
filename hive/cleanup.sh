#!/bin/bash

CONTAINER_NAME=v3io-hive
LOCAL_HIVE_DIR=/tmp/hive
FUSE_HIVE_DIR=/tmp/fuse_hive/hive/data

echo "Stopping $CONTAINER_NAME docker container..."
docker stop $CONTAINER_NAME

echo "Removing $CONTAINER_NAME docker container..."
docker rm $CONTAINER_NAME

if [ -d $LOCAL_HIVE_DIR ]; then
  echo "Removing conetent of the hive local data directory ($LOCAL_HIVE_DIR) ..."
  rm -rf $LOCAL_HIVE_DIR
fi

if [ -d $FUSE_HIVE_DIR ]; then
  echo "Removing content of the hive data directory on fuse mount ($FUSE_HIVE_DIR) ..."
  sudo rm -rf $FUSE_HIVE_DIR/*
fi

echo Done.
