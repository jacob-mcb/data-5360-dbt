{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

with cte_date as (
{{ dbt_date.get_date_dimension("1990-01-01", "2050-12-31") }}
)

SELECT
date_day as date_key,
date_day as date_id,
day_of_week as DayOfWeek,
month_of_year as Month,
quarter_of_year as Quarter,
year_number as Year
from cte_date