{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    oe.employee_key,
    d.date_key,
    e.certification_name,
    e.certification_cost
from {{ ref('stg_employee_certifications') }} e
inner join {{ ref('oliver_dim_employee') }} oe
    on e.first_name = oe.first_name
    and e.last_name = oe.last_name
inner join {{ ref('oliver_dim_date') }} d
    on d.date_key = e.certification_awarded_date

