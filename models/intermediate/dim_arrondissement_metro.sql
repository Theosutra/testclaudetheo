WITH cte_src_arr AS (
    SELECT
        uuid() AS id_arrondissement, 
        a.arr as code_arrondissement,
        a.nccenr as nom_arrondissement,
        as_spatial.geom as geom,
        ST_AsGeoJSON(as_spatial.geom) as geojson
    FROM {{ ref('sta_arrondissement') }} a
    LEFT JOIN {{ ref('sta_arrondissement_spatial') }} as_spatial 
        ON a.arr = as_spatial.code_arrondissement
)

SELECT
    *
FROM cte_src_arr