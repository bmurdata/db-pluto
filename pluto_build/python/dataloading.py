from cook import Importer
import os
import sys

def ETL():
    RECIPE_ENGINE = os.environ.get('RECIPE_ENGINE', '')
    BUILD_ENGINE=os.environ.get('BUILD_ENGINE', '')

    importer = Importer(RECIPE_ENGINE, BUILD_ENGINE)

    importer.import_table(schema_name='dcp_edesignation')
    importer.import_table(schema_name='dcas_facilities_colp')
    importer.import_table(schema_name='dcp_zoningmapindex')
    importer.import_table(schema_name='lpc_historic_districts')
    importer.import_table(schema_name='lpc_landmarks')
    # for spatial joins
    importer.import_table(schema_name='dcp_cdboundaries')
    importer.import_table(schema_name='dcp_censustracts')
    importer.import_table(schema_name='dcp_censusblocks')
    importer.import_table(schema_name='dcp_school_districts')
    importer.import_table(schema_name='dcp_councildistricts')
    # importer.import_table(schema_name='doitt_zipcodes')
    importer.import_table(schema_name='dcp_firecompanies')
    importer.import_table(schema_name='dcp_policeprecincts')
    importer.import_table(schema_name='dcp_healthareas')
    importer.import_table(schema_name='dcp_healthcenters')
    importer.import_table(schema_name='dsny_frequencies')

    # ## Other_datasets - PULLING FROM FTP or PLUTO GitHub repo
    importer.import_table(schema_name='dcp_zoning_maxfar')
    importer.import_table(schema_name='pluto_input_bsmtcode')
    importer.import_table(schema_name='pluto_input_landuse_bldgclass')
    importer.import_table(schema_name='pluto_input_condo_bldgclass')

    # # we'll be working to make these input datasets publicly avaialble 

    # # raw RPAD data from DOF
    importer.import_table(schema_name='pluto_pts')
    # Geocoded RPAD data (includes billing BBL for condo lots and geospatial fields returned by GeoSupport)
    if geocode == 'no':
        importer.import_table(schema_name='pluto_input_geocodes')
    else: 
        pass

    # raw CAMA data from DOF
    importer.import_table(schema_name='pluto_input_cama_dof')

    # raw Digital Tax Map from DOF
    importer.import_table(schema_name='dof_dtm')

    # raw NYC shoreline file from DOF
    importer.import_table(schema_name='dof_shoreline')

    # raw DOF condo table
    importer.import_table(schema_name='dof_condo')

    # DCP zoning datasets
    importer.import_table(schema_name='dcp_commercialoverlay')
    importer.import_table(schema_name='dcp_limitedheight')
    importer.import_table(schema_name='dcp_zoningdistricts')
    importer.import_table(schema_name='dcp_specialpurpose')
    importer.import_table(schema_name='dcp_specialpurposesubdistricts')
    importer.import_table(schema_name='dcp_zoningmapamendments')
    importer.import_table(schema_name='dcp_zoningmapindex')

    # FEMA 2007 and preliminary 2015 100 year flood zones 
    importer.import_table(schema_name='fema_firms2007_100yr')
    importer.import_table(schema_name='fema_pfirms2015_100yr')
    importer.import_table(schema_name='pluto_input_condolot_descriptiveattributes')

    # Spatial features to Zola
    importer.import_table(schema_name='dcp_mih')
    importer.import_table(schema_name='transitzones')
    importer.import_table(schema_name='inclusionary_housing')
    importer.import_table(schema_name='waterfront_access_plan')
    importer.import_table(schema_name='fresh_zones')
    importer.import_table(schema_name='coastal_zone_boundary')
    importer.import_table(schema_name='lower_density_growth_management_areas')
    importer.import_table(schema_name='upland_waterfront_areas')
    importer.import_table(schema_name='appendixj_designated_mdistricts')

if __name__ == "__main__":
    # geocode=sys.argv[1]
    ETL()