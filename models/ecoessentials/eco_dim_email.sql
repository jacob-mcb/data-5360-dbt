{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


select
{{ dbt_utils.generate_surrogate_key(['emailid', 'emailname']) }} as email_key,
emailid,
emailname
FROM {{ source('marketing_landing', 'marketingemails') }}