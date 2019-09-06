#!/bin/bash

# load config
DBNAME='postgres'
DBUSER='postgres'

start=$(date +'%T')
echo "Starting to validate latest pluto"
docker exec pluto psql -U $DBUSER -d $DBNAME -f sql/qc_versioncomparison.sql