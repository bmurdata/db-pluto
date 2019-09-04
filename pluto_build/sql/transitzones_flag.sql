-- calculate how much (total area and percentage) of each lot is covered by a transitzones
-- assign the transitzones to each tax lot
-- the order transitzones districts are assigned is based on which district covers the majority of the lot
-- a district is only assigned if more than 10% of the district covers the lot

DROP TABLE IF EXISTS tzperorder;
CREATE TABLE tzperorder AS (
WITH 
tzper AS (
SELECT p.bbl, 
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
   INNER JOIN transitzones AS n 
    ON ST_Intersects(p.geom, n.geom)
)
SELECT bbl, segbblgeom, (segbblgeom/allbblgeom)*100 as perbblgeom, (segzonegeom/allzonegeom)*100 as perzonegeom, ROW_NUMBER()
  OVER (PARTITION BY bbl
  ORDER BY segbblgeom DESC) AS row_number
  FROM tzper
);


UPDATE pluto_zola a 
SET 
transitzones_flag =
(CASE WHEN perbblgeom >= 10 THEN '1'
ELSE NULL
END)
FROM tzperorder b
WHERE a.bbl::TEXT=b.bbl::TEXT;

DROP TABLE tzperorder;