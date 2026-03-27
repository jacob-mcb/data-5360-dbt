{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

with minutes as (
    select
        seq4() as n
    from table(generator(rowcount => 1440))
)

select
    n as time_key,
    floor(n / 60) as hour,
    mod(n, 60) as minute,
    0 as second
from minutes
order by n
