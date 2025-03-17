{% snapshot snapshot_dim_arrondissement %}

{{ 
    config(
        target_schema='snapshots',
        unique_key='id_arrondissement',
        strategy='timestamp',
        updated_at='snapshot_timestamp'
    )
}}

SELECT 
    *,
    current_timestamp() as snapshot_timestamp,
    EXTRACT(YEAR FROM current_timestamp()) as snapshot_year,
    EXTRACT(MONTH FROM current_timestamp()) as snapshot_month
FROM {{ ref('dim_arrondissement_metro') }}

{% endsnapshot %}
