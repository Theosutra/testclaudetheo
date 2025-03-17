SELECT 
    *,
    insee_dep || insee_arr as code_arrondissement
FROM 
    {{ source('spatial_data', 'ARRONDISSEMENT') }}