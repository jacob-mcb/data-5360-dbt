{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

with cte_date as (
    {{ dbt_date.get_date_dimension("2020-01-01", "2030-12-31") }}
)

select
    date_day as date_key,
    date_day as date,
    extract(day from date_day) as day,
    extract(month from date_day) as month,
    extract(year from date_day) as year
from cte_date
order by date_day
