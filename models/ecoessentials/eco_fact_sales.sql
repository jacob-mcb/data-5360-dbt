{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}
with orders as (
    select *
    from {{ source('ecoessentials_landing', 'order') }}
),
order_line as (
    select *
    from {{ source('ecoessentials_landing', 'order_line') }}
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
    ol.orderid as order_id,
    d.date_key,
    p.product_key,
    c.customer_key,
    cam.campaign_key,
    ol.quantity,
    ol.price,
    ol.discount,
    (ol.price - ol.discount) as price_after_discounts
from order_line ol
join orders o
    on ol.orderid = o.orderid
left join products p
    on ol.productid = p.product_id
left join customers c
    on o.customerid = c.customer_id
left join campaigns cam
    on o.campaignid = cam.campaign_id
left join dates d
    on o.order_date = d.date
