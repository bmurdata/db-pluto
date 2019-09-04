-- Create a pluto supporting table to feed Zola
DROP TABLE IF EXISTS pluto_zola;
SELECT bbl, geom INTO pluto_zola
FROM pluto;

-- Add Zola features
ALTER TABLE pluto_zola
	ADD mandatory_inclusionary_housing_flag text,
	ADD inclusionary_housing_flag text,
	ADD transitzones_flag text,
	ADD waterfront_access_plan_flag text,
	ADD coastal_zone_boundary_flag text,
	ADD lower_density_growth_management_areas_flag text,
	ADD upland_waterfront_areas_flag text,
	ADD appendixj_designated_mdistricts_flag text,
	ADD fresh_zones_flag text
;