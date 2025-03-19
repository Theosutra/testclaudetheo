WITH cte_src_departement AS (
    SELECT
        nextval('departement_id_seq') AS dep_id,
        dwhr.reg_id, 
        d.dep as dep_code_departement,
        d.nccenr as nom_departement,
        ds.geom,
        ST_AsGeoJSON(ds.geom) as geojson
    FROM {{ ref('sta_departement') }} d
    LEFT JOIN {{ ref('sta_departement_spatial') }} ds
        ON d.dep = ds.insee_dep
    LEFT JOIN {{ ref('dwh_region') }} dwhr
        ON d.reg = dwhr.reg_code_region
)

SELECT
    *
FROM cte_src_departement