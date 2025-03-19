WITH cte_src_commune AS (
    SELECT
        nextval('commune_id_seq') AS com_id,
        dwhd.dep_id,  
        c.com as code_commune,
        c.nccenr as nom_commune,
        cs.geom,
        ST_AsGeoJSON(cs.geom) as geojson
    FROM {{ ref('sta_commune') }} c
    LEFT JOIN {{ ref('sta_commune_spatial') }} cs
        ON c.com= cs.insee_com 
    LEFT JOIN {{ ref('dwh_departement') }} dwhd
        ON c.dep = dwhd.dep_code_departement
)

SELECT
    *
FROM cte_src_commune