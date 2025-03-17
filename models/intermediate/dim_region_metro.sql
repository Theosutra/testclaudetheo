WITH cte_src_region AS (
    SELECT
        uuid() AS id_region, 
        r.reg as code_region,
        r.nccenr AS nom_region,
        rs.geom,
        ST_AsGeoJSON(rs.geom) AS geojson
    FROM {{ ref('sta_region') }} r
    LEFT JOIN {{ ref('sta_region_spatial') }} rs
        ON r.reg = rs.insee_reg
)

SELECT
    *
FROM cte_src_region
