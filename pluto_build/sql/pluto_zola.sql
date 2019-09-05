-- Create a pluto supporting table to feed Zola
DROP TABLE IF EXISTS pluto_zola;
SELECT bbl, geom, firm07_fla, pfirm15_fl, edesignum INTO pluto_zola
FROM dcp_mappluto;

ALTER TABLE pluto_zola RENAME firm07_fla to floodplain_firm2007_flag;
ALTER TABLE pluto_zola RENAME pfirm15_fl to floodplain_pfirm2015_flag;
ALTER TABLE pluto_zola RENAME edesignum to e_designations_flag;

UPDATE pluto_zola
SET e_designations_flag = (CASE WHEN e_designations_flag IS NOT NULL THEN '1'
								ELSE NULL
							END);

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

UPDATE pluto_zola
SET geom = ST_MakeValid(geom);