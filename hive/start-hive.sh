#!/bin/bash
set -e

#RUN_AS_USER_NAME=${1:-hive}
#RUN_AS_USER=$(id -u $RUN_AS_USER_NAME):$(id -g $RUN_AS_USER_NAME)

# docker run \
#--detach \
#--restart=no \
#--user $RUN_AS_USER \
#--name v3io-hive \
#-p 13306:3306 \
#iguazio/hive

docker run \
--detach \
--restart=no \
--name v3io-hive \
-p 10000:10000 \
-p 10002:10002 \
iguazio/hive

if [ $? -eq 0 ]; then
    echo
    echo "Hive is running in Docker as $RUN_AS_USER"
    echo Done.
fi
