{% snapshot snapshot_dwh_arrondissement %}

{{ 
    config(
        target_schema='snapshots',
        unique_key='arr_id',
        strategy='timestamp',
        updated_at='snapshot_timestamp'
    )
}}

SELECT 
    *,
    current_localtimestamp() as snapshot_timestamp,
    EXTRACT(YEAR FROM current_localtimestamp()) as snapshot_year,
    EXTRACT(MONTH FROM current_localtimestamp()) as snapshot_month
FROM {{ ref('dwh_arrondissement') }}

{% endsnapshot %}

{% snapshot snapshot_dwh_commune %}

{{ 
    config(
        target_schema='snapshots',
        unique_key='com_id',
        strategy='timestamp',
        updated_at='snapshot_timestamp'
    )
}}

SELECT 
    *,
    current_localtimestamp() as snapshot_timestamp,
    EXTRACT(YEAR FROM current_localtimestamp()) as snapshot_year,
    EXTRACT(MONTH FROM current_localtimestamp()) as snapshot_month
FROM {{ ref('dwh_commune') }}

{% endsnapshot %}

{% snapshot snapshot_dwsh_departement %}

{{ 
    config(
        target_schema='snapshots',
        unique_key='dep_id',
        strategy='timestamp',
        updated_at='snapshot_timestamp'
    )
}}

SELECT 
    *,
    current_localtimestamp() as snapshot_timestamp,
    EXTRACT(YEAR FROM current_localtimestamp()) as snapshot_year,
    EXTRACT(MONTH FROM current_localtimestamp()) as snapshot_month
FROM {{ ref('dwh_departement') }}

{% endsnapshot %}

{% snapshot snapshot_dwh_region %}

{{ 
    config(
        target_schema='snapshots',
        unique_key='reg_id',
        strategy='timestamp',
        updated_at='snapshot_timestamp'
    )
}}

SELECT 
    *,
    current_localtimestamp() as snapshot_timestamp,
    EXTRACT(YEAR FROM current_localtimestamp()) as snapshot_year,
    EXTRACT(MONTH FROM current_localtimestamp()) as snapshot_month
FROM {{ ref('dwh_region') }}

{% endsnapshot %}