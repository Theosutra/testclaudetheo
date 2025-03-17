{{ config(materialized='external', location='data/exports/fct_pop.parquet', options={'row_group_size':'24000','compression':'zstd'}) }}
SELECT *
FROM {{ ref('fct_pop') }}
