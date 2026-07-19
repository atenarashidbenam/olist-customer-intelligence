
USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_seller_performance
AS

SELECT

    s.seller_id,

    s.seller_city,

    s.seller_state,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    COUNT(DISTINCT oi.product_id) AS unique_products,

    SUM(oi.price) AS product_revenue,

    SUM(oi.freight_value) AS freight_revenue,

    SUM(oi.price + oi.freight_value) AS gross_revenue,

    CAST(
        AVG(oi.price)
        AS DECIMAL(18,2)
    ) AS average_product_price

FROM core.sellers AS s

INNER JOIN core.order_items AS oi
    ON s.seller_id = oi.seller_id

INNER JOIN core.orders AS o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY

    s.seller_id,
    s.seller_city,
    s.seller_state;
GO