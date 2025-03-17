-- Corrected fct_geo.sql model
WITH commune_dim AS (
    SELECT
        id_commune,
        code_commune
    FROM {{ ref('dim_commune_metro') }}
),

commune_source AS (
    SELECT
        com as code_commune,
        dep as code_departement,
        reg as code_region
    FROM {{ ref('sta_commune') }}
),

departement_dim AS (
    SELECT
        id_departement,
        code_departement
    FROM {{ ref('dim_departement_metro') }}
),

region_dim AS (
    SELECT
        id_region,
        code_region
    FROM {{ ref('dim_region_metro') }}
),

arrondissement_commune_mapping AS (
    SELECT
        a.arr as code_arrondissement,
        c.com as code_commune
    FROM {{ ref('sta_commune') }} c
    JOIN {{ ref('sta_arrondissement') }} a
        ON c.dep = a.dep
),

arrondissement_dim AS (
    SELECT
        id_arrondissement,
        code_arrondissement
    FROM {{ ref('dim_arrondissement_metro') }}
)

SELECT
    uuid() AS id_fctgeo,
    c.id_commune,
    d.id_departement,
    r.id_region,
    a.id_arrondissement
FROM commune_dim c
JOIN commune_source cs
    ON c.code_commune = cs.code_commune
LEFT JOIN departement_dim d
    ON cs.code_departement = d.code_departement
LEFT JOIN region_dim r
    ON cs.code_region = r.code_region
LEFT JOIN arrondissement_commune_mapping acm
    ON c.code_commune = acm.code_commune
LEFT JOIN arrondissement_dim a
    ON acm.code_arrondissement = a.code_arrondissement