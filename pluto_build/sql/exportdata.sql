-- export the datasets

-- create temp table with correct data schema
DROP TABLE IF EXISTS export_mappluto;
CREATE TABLE export_mappluto AS (
SELECT
	gid::integer 
	borough,
	block::numeric,
	lot::integer,
	cd::integer,
	ct2010,
	cb2010,
	schooldist,
	council::integer,
	zipcode::numeric,
	firecomp,
	policeprct::integer,
	healthcent,
	healtharea::integer,
	sanitboro,
	sanitdistr,
	sanitsub,
	address,
	zonedist1,
	zonedist2,
	zonedist3,
	zonedist4,
	overlay1,
	overlay2,
	spdist1,
	spdist2,
	spdist3,
	ltdheight,
	splitzone,
	bldgclass,
	landuse,
	easements::integer,
	ownertype,
	ownername,
	lotarea::numeric,
	bldgarea::numeric,
	comarea::numeric,
	resarea::numeric,
	officearea::numeric,
	retailarea::numeric,
	garagearea::numeric,
	strgearea::numeric,
	factryarea::numeric,
	otherarea::numeric,
	areasource,
	numbldgs::numeric,
	numfloors::numeric,
	unitsres::numeric,
	unitstotal::numeric,
	lotfront::numeric,
	lotdepth::numeric,
	bldgfront::numeric,
	bldgdepth::numeric,
	ext,
	proxcode,
	irrlotcode,
	lottype,
	bsmtcode,
	assessland::numeric,
	assesstot::numeric,
	exemptland::numeric,
	exempttot::numeric,
	yearbuilt::integer,
	yearalter1::integer,
	yearalter2::integer,
	histdist,
	landmark,
	BuiltFAR::numeric,
	ResidFAR::numeric,
	CommFAR::numeric,
	FacilFAR::numeric,
	BoroCode::numeric,
	BBL::numeric,
	CondoNo::numeric,
	Tract2010,
	XCoord::numeric,
	YCoord::numeric,
	ZoneMap,
	ZMCode,
	Sanborn,
	TaxMap,
	EDesigNum,
	APPBBL::numeric,
	APPDate,
	PLUTOMapID,
	FIRM07_FLA,
	PFIRM15_FL,
	Version,
	MAPPLUTO_F::integer
FROM dcp_mappluto_18v11);

-- Set the projection to state plane
UPDATE export_mappluto
SET geom = ST_Transform(geom,'4326','2263');


\copy (SELECT * FROM export_mappluto) TO '/prod/db-pluto/pluto_build/output/pluto.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS export_mappluto;