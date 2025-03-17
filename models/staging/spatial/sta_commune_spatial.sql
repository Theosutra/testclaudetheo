SELECT 
    *
FROM 
    {{ source('spatial_data', 'COMMUNE') }}