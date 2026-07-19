USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_product_performance
AS

SELECT
    p.product_id,

    pct.product_category_name_english AS product_category,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    SUM(oi.price) AS product_revenue,

    SUM(oi.freight_value) AS freight_revenue,

    SUM(oi.price + oi.freight_value) AS gross_revenue,

    SUM(oi.order_item_id) AS total_items_sold,

    CAST(
        AVG(oi.price) AS DECIMAL(18,2)
    ) AS average_price

FROM core.products AS p

INNER JOIN core.order_items AS oi
    ON p.product_id = oi.product_id

INNER JOIN core.orders AS o
    ON oi.order_id = o.order_id

LEFT JOIN core.product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

WHERE o.order_status = 'delivered'

GROUP BY
    p.product_id,
    pct.product_category_name_english;
GO