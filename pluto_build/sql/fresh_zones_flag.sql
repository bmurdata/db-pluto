-- calculate how much (total area and percentage) of each lot is covered by a fresh zones
-- assign the fresh zones to each tax lot
-- the order fresh zones districts are assigned is based on which district covers the majority of the lot
-- a district is only assigned if more than 10% of the district covers the lot

DROP TABLE IF EXISTS fzperorder;
CREATE TABLE fzperorder AS (
WITH 
fzper AS (
SELECT p.bbl, n.name,
  (ST_Area(CASE 
    WHEN ST_CoveredBy(p.geom, n.geom) 
    THEN p.geom 
    ELSE 
    ST_Multi(
      ST_Intersection(p.geom,n.geom)
      ) 
    END)) as segbblgeom,
  ST_Area(p.geom) as allbblgeom,
  (ST_Area(CASE 
    WHEN ST_CoveredBy(n.geom, p.geom) 
    THEN n.geom 
    ELSE 
    ST_Multi(
      ST_Intersection(n.geom,p.geom)
      ) 
    END)) as segzonegeom,
  ST_Area(n.geom) as allzonegeom
 FROM pluto_zola AS p 
   INNER JOIN fresh_zones AS n 
    ON ST_Intersects(p.geom, n.geom)
)
SELECT bbl, name, segbblgeom, (segbblgeom/allbblgeom)*100 as perbblgeom, (segzonegeom/allzonegeom)*100 as perzonegeom, ROW_NUMBER()
  OVER (PARTITION BY bbl
  ORDER BY segbblgeom DESC) AS row_number
  FROM fzper
);


UPDATE pluto_zola a 
SET 
fresh_zones_flag =
(CASE WHEN perbblgeom >= 10 THEN name
ELSE NULL
END)
FROM fzperorder b
WHERE a.bbl::TEXT=b.bbl::TEXT;

DROP TABLE fzperorder;