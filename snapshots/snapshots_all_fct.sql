{% snapshot snapshot_dwh_population %}

{{ 
    config(
        target_schema='snapshots',
        unique_key='pop_id',
        strategy='timestamp',
        updated_at='snapshot_timestamp'
    )
}}

SELECT 
    *,
    current_localtimestamp() as snapshot_timestamp,
    EXTRACT(YEAR FROM current_localtimestamp()) as snapshot_year,
    EXTRACT(MONTH FROM current_localtimestamp()) as snapshot_month
FROM {{ ref('dwh_population') }}

{% endsnapshot %}