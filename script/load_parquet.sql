-- Création du stage interne si celui-ci n'existe pas
CREATE STAGE IF NOT EXISTS model_spatial
  FILE_FORMAT = (TYPE = 'PARQUET');

-- Commandes à exécuter après avoir déplacé les fichiers dans C:\temp\parquet_files
PUT file://C:/temp/parquet_files/fct_pop.parquet @model_spatial/fct_pop AUTO_COMPRESS=TRUE;
PUT file://C:/temp/parquet_files/fct_geo.parquet @model_spatial/fact_geo AUTO_COMPRESS=TRUE;
PUT file://C:/temp/parquet_files/dim_commune_metro.parquet @model_spatial/dim_commune_metro AUTO_COMPRESS=TRUE;
PUT file://C:/temp/parquet_files/dim_arrondissement_metro.parquet @model_spatial/dim_arrondissement_metro AUTO_COMPRESS=TRUE;
PUT file://C:/temp/parquet_files/dim_departement_metro.parquet @model_spatial/dim_departement_metro AUTO_COMPRESS=TRUE;
PUT file://C:/temp/parquet_files/dim_region.metro.parquet @model_spatial/dim_region_metro AUTO_COMPRESS=TRUE;

-- Liste des fichiers dans le stage pour vérification
LIST @model_spatial; 