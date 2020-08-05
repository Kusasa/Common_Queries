1. Combined Animals virtual layer:
CREATE OR REPLACE VIEW iucn_animals
AS SELECT * FROM AMPHIBIANS
UNION SELECT * FROM ANGELFISH
UNION SELECT * FROM BLENNIES
UNION SELECT * FROM BONEFISHES_TARPONS
UNION SELECT * FROM BUTTERFLYFISH
UNION SELECT * FROM CLUPEIFORMES
UNION SELECT * FROM GROUPERS
UNION SELECT * FROM HAGFISH
UNION SELECT * FROM MAMMALS
UNION SELECT * FROM PUFFERFISH
UNION SELECT * FROM REPTILES
UNION SELECT * FROM SEABREAMS_PORGIES
UNION SELECT * FROM SHARKS_RAYS_CHIMAERAS
UNION SELECT * FROM SURGEONFISHES_TANGS_UNICORNFISHES
UNION SELECT * FROM TUNAS_BILLFISHES
UNION SELECT * FROM WRASSES_PARROTFISHES;


2. IUCN Terrestrial Mammals in ER Sites:
SELECT a.name er_site, b.binomial species, a.geom geom FROM "er_sites" a, "terrestrial_mammals" b WHERE st_intersects(a.geom, b.geom);


3. IUCN Critically-Endangered Terrestrial Mammals in ER Sites:
SELECT a.name er_site, b.binomial species, CASE WHEN b.category = 'CR' THEN 'Critically Endangered' ELSE '' END status, a.geom geom FROM "er_sites" a, "terrestrial_mammals" b WHERE st_intersects(a.geom, b.geom) AND UPPER(b.category)='CR';


4. Sum IUCN Critically-Endangered Terrestrial Mammals per ER Sites:
WITH site_CR_T_Mammals AS (
SELECT a.name er_site, b.binomial species, CASE WHEN b.category = 'CR' THEN 'Critically Endangered' ELSE '' END status, a.geom geom FROM "er_sites" a, "terrestrial_mammals" b WHERE st_intersects(a.geom, b.geom) AND UPPER(b.category)='CR'
)
SELECT MIN(er_site) er_site, MIN(status) status, COUNT(er_site) Site_Impact, string_agg(species, '; ') Species_List, MIN(geom) geom FROM site_CR_T_Mammals GROUP BY er_site;

