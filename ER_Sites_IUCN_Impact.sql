1. IUCN Terrestrial Mammals in ER Sites:
SELECT a.name er_site, b.binomial species, a.geom geom FROM "er_sites" a, "terrestrial_mammals" b WHERE st_intersects(a.geom, b.geom);


2. IUCN Critically-Endangered Terrestrial Mammals in ER Sites:
SELECT a.name er_site, b.binomial species, CASE WHEN b.category = 'CR' THEN 'Critically Endangered' ELSE '' END status, a.geom geom FROM "er_sites" a, "terrestrial_mammals" b WHERE st_intersects(a.geom, b.geom) AND UPPER(b.category)='CR';

3. Sum IUCN Critically-Endangered Terrestrial Mammals per ER Sites:
WITH site_CR_T_Mammals AS (
SELECT a.name er_site, b.binomial species, CASE WHEN b.category = 'CR' THEN 'Critically Endangered' ELSE '' END status, a.geom geom FROM "er_sites" a, "terrestrial_mammals" b WHERE st_intersects(a.geom, b.geom) AND UPPER(b.category)='CR'
)
SELECT MIN(er_site) er_site, MIN(status) status, COUNT(er_site) Site_Impact, string_agg(species, '; ') Species_List, MIN(geom) geom FROM site_CR_T_Mammals GROUP BY er_site;

