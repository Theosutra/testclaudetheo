-- Table fct_pop
CREATE OR REPLACE TABLE fct_pop (
    id_fctpop UUID PRIMARY KEY,
    id_commune UUID,
    id_region UUID,
    id_departement UUID,
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
    id_fctgeo UUID PRIMARY KEY,
    id_commune UUID,
    id_arrondissement UUID,
    id_departement UUID,
    id_region UUID
);

-- Table dim_commune_metro
CREATE OR REPLACE TABLE dim_commune_metro (
    id_commune UUID PRIMARY KEY,
    nom_commune VARCHAR(255),
    code_insee VARCHAR(50),
    id_arrondissement UUID,
    id_departement UUID,
    id_region UUID
);

-- Table dim_arrondissement_metro
CREATE OR REPLACE TABLE dim_arrondissement_metro (
    id_arrondissement UUID PRIMARY KEY,
    nom_arrondissement VARCHAR(255),
    code_arrondissement VARCHAR(50),
    id_departement UUID,
    id_region UUID
);

-- Table dim_departement_metro
CREATE OR REPLACE TABLE dim_departement_metro (
    id_departement UUID PRIMARY KEY,
    nom_departement VARCHAR(255),
    code_departement VARCHAR(50),
    id_region UUID
);

-- Table dim_region_metro
CREATE OR REPLACE TABLE dim_region_metro (
    id_region UUID PRIMARY KEY,
    nom_region VARCHAR(255),
    code_region VARCHAR(50)
);