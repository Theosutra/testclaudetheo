WITH cte_src_commune AS (
    SELECT
        uuid() AS id_commune, 
        c.com as code_commune,
        c.nccenr as nom_commune,
        cs.geom,
        ST_AsGeoJSON(cs.geom) as geojson
    FROM {{ ref('sta_commune') }} c
    LEFT JOIN {{ ref('sta_commune_spatial') }} cs
        ON c.com= cs.insee_com 
)

SELECT
    *
FROM cte_src_commune