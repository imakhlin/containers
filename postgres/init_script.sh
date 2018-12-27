#!/bin/bash

#set -x

echo "---> Running as: " `id`

if [ "$PGDATA" == "" ]; then
    PGDATA="/var/lib/postgresql/data"
fi

ORIGINAL_PGDATA=$PGDATA

# Backup current postgres data dir
PGDATA_BACKUP=~/pgdata_backup
if [ -d $ORIGINAL_PGDATA ] && [ ! -d $PGDATA_BACKUP ]; then
  mkdir -p $PGDATA_BACKUP
  mv $ORIGINAL_PGDATA $PGDATA_BACKUP/
fi

INIT_PGDATA=${PGDATA}_init
if [ ! -d $INIT_PGDATA ]; then
  export PGDATA=$INIT_PGDATA

  # Prepare initialisation directory
  mkdir -p $PGDATA

  echo "Initialising PostgreSQL..."
  pg_ctl initdb --pgdata=$PGDATA

  # Copy init dir into the working dir
  if [ ! -d $ORIGINAL_PGDATA ]; then
    mkdir -p $ORIGINAL_PGDATA
  fi
  cp -r $PGDATA/* $ORIGINAL_PGDATA/
  chmod -R 0750 $ORIGINAL_PGDATA

  # Modify access policy to allow access to PostgreSQL from outside of the Docker container
  echo "# Allow access from outside the Docker container" >> $ORIGINAL_PGDATA/pg_hba.conf
  echo "host    all             all             172.17.0.1/32           trust" >> $ORIGINAL_PGDATA/pg_hba.conf

  # Restore the original data dir
  export PGDATA=$ORIGINAL_PGDATA
fi

# Run postgres
echo "Starting PostgreSQL..."
postgres
