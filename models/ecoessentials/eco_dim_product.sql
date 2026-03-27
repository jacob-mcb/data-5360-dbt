{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


select
{{ dbt_utils.generate_surrogate_key(['product_id', 'product_type']) }} as product_key,
product_id,
product_type as type,
product_name as name
FROM {{ source('ecoessentials_landing', 'product') }}