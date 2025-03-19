-- Création des tables directement avec le bon format

-- Table fct_pop
CREATE OR REPLACE TABLE fct_pop (
    id_fctpop VARCHAR(36) PRIMARY KEY,
    id_commune VARCHAR(36),
    id_region VARCHAR(36),
    id_departement VARCHAR(36),
    population_2022 FLOAT,
    population_2021 FLOAT,
    population_2020 FLOAT,
    population_2019 FLOAT,
    population_2018 FLOAT,
    population_2017 FLOAT,
    population_2016 FLOAT,
    population_2015 FLOAT,
    population_2014 FLOAT,
    population_2013 FLOAT,
    population_2012 FLOAT,
    population_2011 FLOAT,
    population_2010 FLOAT,
    population_2009 FLOAT,
    population_2008 FLOAT,
    population_2007 FLOAT,
    population_2006 FLOAT
);

-- Table fct_geo
CREATE OR REPLACE TABLE fct_geo (
    id_fctgeo VARCHAR(36) PRIMARY KEY,
    id_commune VARCHAR(36),
    id_arrondissement VARCHAR(36),
    id_departement VARCHAR(36),
    id_region VARCHAR(36)
);

-- Table dim_commune_metro
CREATE OR REPLACE TABLE dim_commune_metro (
    id_commune VARCHAR(36) PRIMARY KEY,
    nom_commune VARCHAR(255),
    code_insee VARCHAR(50),
    id_arrondissement VARCHAR(36),
    id_departement VARCHAR(36),
    id_region VARCHAR(36)
);

-- Table dim_arrondissement_metro
CREATE OR REPLACE TABLE dim_arrondissement_metro (
    id_arrondissement VARCHAR(36) PRIMARY KEY,
    nom_arrondissement VARCHAR(255),
    code_arrondissement VARCHAR(50),
    id_departement VARCHAR(36),
    id_region VARCHAR(36)
);

-- Table dim_departement_metro
CREATE OR REPLACE TABLE dim_departement_metro (
    id_departement VARCHAR(36) PRIMARY KEY,
    nom_departement VARCHAR(255),
    code_departement VARCHAR(50),
    id_region VARCHAR(36)
);

-- Table dim_region_metro
CREATE OR REPLACE TABLE dim_region_metro (
    id_region VARCHAR(36) PRIMARY KEY,
    nom_region VARCHAR(255),
    code_region VARCHAR(50)
);

-- Chargement des données depuis les fichiers Parquet en sélectionnant uniquement les colonnes nécessaires
COPY INTO fct_pop (
    id_fctpop, id_commune, id_region, id_departement,
    population_2022, population_2021, population_2020, population_2019,
    population_2018, population_2017, population_2016, population_2015,
    population_2014, population_2013, population_2012, population_2011,
    population_2010, population_2009, population_2008, population_2007,
    population_2006
)
FROM (
    SELECT 
        $1:id_fctpop::VARCHAR,
        $1:id_commune::VARCHAR,
        $1:id_region::VARCHAR,
        $1:id_departement::VARCHAR,
        $1:population_2022::FLOAT,
        $1:population_2021::FLOAT,
        $1:population_2020::FLOAT,
        $1:population_2019::FLOAT,
        $1:population_2018::FLOAT,
        $1:population_2017::FLOAT,
        $1:population_2016::FLOAT,
        $1:population_2015::FLOAT,
        $1:population_2014::FLOAT,
        $1:population_2013::FLOAT,
        $1:population_2012::FLOAT,
        $1:population_2011::FLOAT,
        $1:population_2010::FLOAT,
        $1:population_2009::FLOAT,
        $1:population_2008::FLOAT,
        $1:population_2007::FLOAT,
        $1:population_2006::FLOAT
    FROM @model_spatial/fct_pop/fct_pop.parquet
)
FILE_FORMAT = (TYPE = PARQUET);

-- Chargement de fct_geo
COPY INTO fct_geo (
    id_fctgeo, id_commune, id_arrondissement, id_departement, id_region
)
FROM (
    SELECT 
        $1:id_fctgeo::VARCHAR,
        $1:id_commune::VARCHAR,
        $1:id_arrondissement::VARCHAR,
        $1:id_departement::VARCHAR,
        $1:id_region::VARCHAR
    FROM @model_spatial/fact_geo/fct_geo.parquet
)
FILE_FORMAT = (TYPE = PARQUET);

-- Chargement de dim_commune_metro
COPY INTO dim_commune_metro (
    id_commune, nom_commune, code_insee, id_arrondissement, id_departement, id_region
)
FROM (
    SELECT 
        $1:id_commune::VARCHAR,
        $1:nom_commune::VARCHAR,
        $1:code_insee::VARCHAR,
        $1:id_arrondissement::VARCHAR,
        $1:id_departement::VARCHAR,
        $1:id_region::VARCHAR
    FROM @model_spatial/dim_commune_metro/dim_commune_metro.parquet
)
FILE_FORMAT = (TYPE = PARQUET);

-- Chargement de dim_arrondissement_metro
COPY INTO dim_arrondissement_metro (
    id_arrondissement, nom_arrondissement, code_arrondissement, id_departement, id_region
)
FROM (
    SELECT 
        $1:id_arrondissement::VARCHAR,
        $1:nom_arrondissement::VARCHAR,
        $1:code_arrondissement::VARCHAR,
        $1:id_departement::VARCHAR,
        $1:id_region::VARCHAR
    FROM @model_spatial/dim_arrondissement_metro/dim_arrondissement_metro.parquet
)
FILE_FORMAT = (TYPE = PARQUET);

-- Chargement de dim_departement_metro
COPY INTO dim_departement_metro (
    id_departement, nom_departement, code_departement, id_region
)
FROM (
    SELECT 
        $1:id_departement::VARCHAR,
        $1:nom_departement::VARCHAR,
        $1:code_departement::VARCHAR,
        $1:id_region::VARCHAR
    FROM @model_spatial/dim_departement_metro/dim_departement_metro.parquet
)
FILE_FORMAT = (TYPE = PARQUET);

-- Chargement de dim_region_metro
COPY INTO dim_region_metro (
    id_region, nom_region, code_region
)
FROM (
    SELECT 
        $1:id_region::VARCHAR,
        $1:nom_region::VARCHAR,
        $1:code_region::VARCHAR
    FROM @model_spatial/dim_region_metro/dim_region.metro.parquet
)
FILE_FORMAT = (TYPE = PARQUET);

-- Vérification des données chargées
SELECT COUNT(*) FROM fct_pop;
SELECT COUNT(*) FROM fct_geo;
SELECT COUNT(*) FROM dim_commune_metro;
SELECT COUNT(*) FROM dim_arrondissement_metro;
SELECT COUNT(*) FROM dim_departement_metro;
SELECT COUNT(*) FROM dim_region_metro;