{{ config(materialized='external', location='data/exports/dwh_population.parquet', options={'row_group_size':'24000','compression':'zstd'}) }}
SELECT *
FROM {{ ref('dwh_population') }}
