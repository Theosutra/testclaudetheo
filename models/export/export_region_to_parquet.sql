{{ config(materialized='external', location='data/exports/dim_region.metro.parquet', options={'row_group_size':'24000','compression':'zstd'}) }}
SELECT *
FROM {{ ref('dim_region_metro') }}
