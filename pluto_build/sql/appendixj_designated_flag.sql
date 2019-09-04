-- calculate how much (total area and percentage) of each lot is covered by a upland waterfront areas
-- assign the upland waterfront areas to each tax lot
-- the order upland waterfront areas districts are assigned is based on which district covers the majority of the lot
-- a district is only assigned if more than 10% of the district covers the lot

DROP TABLE IF EXISTS admperorder;
CREATE TABLE admperorder AS (
WITH 
admper AS (
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
   INNER JOIN appendixj_designated_mdistricts AS n 
    ON ST_Intersects(p.geom, n.geom)
)
SELECT bbl, segbblgeom, (segbblgeom/allbblgeom)*100 as perbblgeom, (segzonegeom/allzonegeom)*100 as perzonegeom, ROW_NUMBER()
  OVER (PARTITION BY bbl
  ORDER BY segbblgeom DESC) AS row_number
  FROM admper
);


UPDATE pluto_zola a 
SET 
appendixj_designated_mdistricts_flag =
(CASE WHEN perbblgeom >= 10 THEN '1'
ELSE NULL
END)
FROM admperorder b
WHERE a.bbl::TEXT=b.bbl::TEXT;

DROP TABLE admperorder;