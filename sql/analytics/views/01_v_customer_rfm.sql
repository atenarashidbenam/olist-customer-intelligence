USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_customer_rfm
AS

SELECT
    c.customer_unique_id,

    MAX(o.order_purchase_timestamp) AS last_purchase_date,

    COUNT(DISTINCT o.order_id) AS frequency,

    SUM(oi.price) AS product_revenue,

    SUM(oi.freight_value) AS freight_revenue,

    SUM(oi.price + oi.freight_value) AS monetary

FROM core.customers AS c

INNER JOIN core.orders AS o
    ON c.customer_id = o.customer_id

INNER JOIN core.order_items AS oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    c.customer_unique_id;
GO