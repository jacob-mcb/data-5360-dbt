{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
customer_id as customer_key,
customer_id, 
first_name, 
Last_name,  
phone_number,
email,
state
FROM {{ source('oliver_landing', 'customer') }}