{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

with order_src as (
    select *
    from {{ source('ecoessentials_landing', 'ORDER') }}
),

order_line as (
    select *
    from {{ source('ecoessentials_landing', 'order_line') }}
),

product_src as (
    select *
    from {{ source('ecoessentials_landing', 'product') }}
),

products as (
    select *
    from {{ ref('eco_dim_product') }}
),

customers as (
    select *
    from {{ ref('eco_dim_customer') }}
),

campaigns as (
    select *
    from {{ ref('eco_dim_promotional_campaign') }}
),

dates as (
    select *
    from {{ ref('eco_dim_date') }}
)
select
    ol.order_id as order_id,

    d.date_key,
    p.product_key,
    c.customer_key,
    cam.campaign_key,
  
    ol.quantity,
    ps.price,                
    ol.discount,
    ol.price_after_discount 

from order_line ol
join order_src o
    on ol.order_id = o.order_id


left join products p
    on ol.product_id = p.product_id


left join product_src ps
    on ol.product_id = ps.product_id

left join customers c
    on o.customer_id = c.customer_id

left join campaigns cam
    on ol.campaign_id = cam.campaign_id

left join dates d
    on o.order_timestamp = d.date