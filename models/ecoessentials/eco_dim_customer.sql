{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

select
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'customer_first_name']) }} as customer_key,
    c.customer_id,
    COALESCE(c.customer_first_name, m.subscriberfirstname) AS customer_first_name,
    COALESCE(c.customer_last_name, m.subscriberlastname) AS customer_last_name,
    m.subscriberid as subscriber_id,
    c.customer_phone,
    c.customer_address,
    c.customer_city,
    c.customer_state,
    c.customer_zip,
    c.customer_country,
    c.customer_email
from {{ source('ecoessentials_landing', 'customer') }} c
FULL OUTER JOIN {{ source('marketing_landing', 'marketingemails') }} m
    on try_to_number(c.customer_id) = try_to_number(m.customerid)