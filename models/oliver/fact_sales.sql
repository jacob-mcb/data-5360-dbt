{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    c.customer_key,
    e.employee_key,
    s.store_key,
    p.product_key,
    d.date_key,
    ol.quantity,
    ol.quantity * ol.unit_price as dollars_sold,
    ol.unit_price
FROM {{ source('oliver_landing', 'orderline') }} ol
INNER JOIN {{ source('oliver_landing', 'orders') }} o ON ol.Order_ID = o.order_id
INNER JOIN {{ ref('oliver_dim_product') }} p ON ol.Product_ID = p.Product_ID 
INNER JOIN {{ ref('oliver_dim_customer') }} c ON o.Customer_ID = c.Customer_ID 
INNER JOIN {{ ref('oliver_dim_employee') }} e ON o.Employee_ID = e.Employee_ID
INNER JOIN {{ ref('oliver_dim_store') }} s ON o.Store_ID = s.Store_ID 
INNER JOIN {{ ref('oliver_dim_date') }} d ON o.Order_Date = d.date_id