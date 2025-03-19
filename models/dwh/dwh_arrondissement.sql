WITH cte_src_arr AS (
    SELECT
        nextval('arrondissement_id_seq') AS arr_id,
        dwhc.com_id,
        a.arr as code_arrondissement,
        a.nccenr as nom_arrondissement,
        as_spatial.geom as geom,
        ST_AsGeoJSON(as_spatial.geom) as geojson
    FROM {{ ref('sta_arrondissement') }} a
    LEFT JOIN {{ ref('sta_arrondissement_spatial') }} as_spatial 
        ON a.arr = as_spatial.code_arrondissement
    LEFT JOIN {{ ref('dwh_commune') }} dwhc
        ON d.reg = dwhc.com_code_commune
)

SELECT
    *
FROM cte_src_arr