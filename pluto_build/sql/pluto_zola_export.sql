DROP TABLE IF EXISTS zola_export;
SELECT bbl, floodplain_firm2007_flag, floodplain_pfirm2015_flag, e_designations_flag,
mandatory_inclusionary_housing_flag, inclusionary_housing_flag, transitzones_flag, 
waterfront_access_plan_flag, coastal_zone_boundary_flag, lower_density_growth_management_areas_flag, 
upland_waterfront_areas_flag, appendixj_designated_mdistricts_flag,fresh_zones_flag
INTO zola_export 
FROM pluto_zola;

\COPY (SELECT * FROM zola_export) TO 'output/pluto_zola.csv' DELIMITER ',' CSV HEADER;