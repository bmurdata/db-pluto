#!/bin/bash

# load config
DBNAME='postgres'
DBUSER='postgres'

# some final processing is done in Esri to create the Esri file formats
# please go to NYC Planning's Bytes of the Big Apple to download the offical versions of PLUTO and MapPLUTO
# https://www1.nyc.gov/site/planning/data-maps/open-data.page

echo "Exporting pluto csv and shapefile"

docker exec pluto pgsql2shp -u $DBUSER -f output/mappluto $DBNAME "SELECT * FROM pluto_zola WHERE geom IS NOT NULL"

docker exec pluto psql -U $DBUSER -d $DBNAME -f sql/export.sql
