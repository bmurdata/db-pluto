#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME='postgres'
DBUSER='postgres'

start=$(date +'%T')
echo "Starting to generate corrections for PLUTO"
docker exec pluto psql -U $DBUSER -d $DBNAME -f sql/corr_yearbuilt_lpc.sql