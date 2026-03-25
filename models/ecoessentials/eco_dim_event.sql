{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


select
{{ dbt_utils.generate_surrogate_key(['emaileventid', 'eventtype']) }} as event_key,
emaileventid,
eventtype
FROM {{ source('marketing_landing', 'marketingemails') }}