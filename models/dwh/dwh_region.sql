WITH cte_src_region AS (
    SELECT
        nextval('region_id_seq') AS reg_id,
        r.reg as reg_code_region,
        r.nccenr AS reg_nom_region,
        rs.geom as reg_geom,
        ST_AsGeoJSON(rs.geom) AS reg_geojson
    FROM {{ ref('sta_region') }} r
    LEFT JOIN {{ ref('sta_region_spatial') }} rs
        ON r.reg = rs.insee_reg
)

SELECT
    *
FROM cte_src_region
