{{ config(materialized='external', location='data/exports/dim_arrondissement_metro.parquet', options={'row_group_size':'24000','compression':'zstd'}) }}
SELECT *
FROM {{ ref('dim_arrondissement_metro') }}
