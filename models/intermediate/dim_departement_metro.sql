WITH cte_src_departement AS (
    SELECT
        uuid() AS id_departement, 
        d.dep as code_departement,
        d.nccenr as nom_departement,
        ds.geom,
        ST_AsGeoJSON(ds.geom) as geojson
    FROM {{ ref('sta_departement') }} d
    LEFT JOIN {{ ref('sta_departement_spatial') }} ds
        ON d.dep = ds.insee_dep
)

SELECT
    *
FROM cte_src_departement