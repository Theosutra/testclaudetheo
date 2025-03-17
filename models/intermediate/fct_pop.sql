WITH population_data AS (
    SELECT
        p.codgeo as code_commune,
        p.dep as code_departement,
        p.reg as code_region,
        p.pmun2022 as population_2022,
        p.pmun2021 as population_2021,
        p.pmun2020 as population_2020,
        p.pmun2019 as population_2019,
        p.pmun2018 as population_2018,
        p.pmun2017 as population_2017,
        p.pmun2016 as population_2016,
        p.pmun2015 as population_2015,
        p.pmun2014 as population_2014,
        p.pmun2013 as population_2013,
        p.pmun2012 as population_2012,
        p.pmun2011 as population_2011,
        p.pmun2010 as population_2010,
        p.pmun2009 as population_2009,
        p.pmun2008 as population_2008,
        p.pmun2007 as population_2007,
        p.pmun2006 as population_2006
    FROM {{ ref('sta_population') }} p
),

commune_dim AS (
    SELECT
        id_commune,
        code_commune  
    FROM {{ ref('dim_commune_metro') }}
),

region_dim AS (
    SELECT
        id_region,
        code_region  
    FROM {{ ref('dim_region_metro') }}
),

departement_dim AS (
    SELECT
        id_departement,
        code_departement  
    FROM {{ ref('dim_departement_metro') }}
)

SELECT
    uuid() AS id_fctpop,
    c.id_commune as id_commune,
    r.id_region as id_region,
    d.id_departement as id_departement,
    p.population_2022,
    p.population_2021,
    p.population_2020,
    p.population_2019,
    p.population_2018,
    p.population_2017,
    p.population_2016,
    p.population_2015,
    p.population_2014,
    p.population_2013,
    p.population_2012,
    p.population_2011,
    p.population_2010,
    p.population_2009,
    p.population_2008,
    p.population_2007,
    p.population_2006
FROM population_data p
INNER JOIN commune_dim c
    ON p.code_commune = c.code_commune
LEFT JOIN departement_dim d
    ON p.code_departement = d.code_departement
LEFT JOIN region_dim r
    ON p.code_region = r.code_region