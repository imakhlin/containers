#!/bin/bash

set -x

MOUNT_PATH=/tmp/fuse_postgres
SESSION_TOKEN="7ca53a12-1351-4182-b093-69cf9fc3b5f8"

if [ "$1" != "" ]; then
  SESSION_TOKEN=$1
fi

echo "Delete old mount directory ${MOUNT_PATH}..."
rm -rf ${MOUNT_PATH}
echo "Create new mount directory at ${MOUNT_PATH}"
mkdir -p ${MOUNT_PATH}

#echo "Run fuse mount in screen session..."
#screen -L -d -m -S _tmp_fuse_postgres bash -c \
/home/iguazio/igz/clients/fuse/bin/v3io_adapters_fuse \
	-u \
	-m ${MOUNT_PATH} \
        -d \
	-c tcp://10.0.73.10:1234,tcp://10.0.73.11:1234 \
	-r 2 \
	-s $SESSION_TOKEN \
	-i 1 > /var/log/iguazio/fuse._tmp_fuse_postgres.log 2>&1
