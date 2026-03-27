{{ config(

    materialized = 'table',

    schema = 'dw_ecoessentials'

) }}


SELECT

    d.date_key,

    c.customer_key,

    ca.campaign_key,

    e.event_key,

    t.time_key,

    em.email_key

FROM {{ source('marketing_landing', 'marketingemails') }} m

LEFT JOIN {{ ref('eco_dim_customer') }} c ON m.subscriberid = c.subscriber_id 

LEFT JOIN {{ ref('eco_dim_promotional_campaign') }} ca ON m.campaignid = ca.campaign_id 

LEFT JOIN {{ ref('eco_dim_date') }} d ON CAST(m.eventtimestamp AS DATE) = d.date

LEFT JOIN {{ ref('eco_dim_event') }} e ON m.emaileventid = e.emaileventid

LEFT JOIN {{ ref('eco_dim_time') }} t ON (

    (DATE_PART('HOUR', m.eventtimestamp) * 10000) +

    (DATE_PART('MINUTE', m.eventtimestamp) * 100) +

    DATE_PART('SECOND', m.eventtimestamp)

) = t.time_key

LEFT JOIN {{ ref('eco_dim_email') }} em ON m.emailid = em.emailid