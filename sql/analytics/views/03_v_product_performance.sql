USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_product_performance
AS

SELECT
    p.product_id,

    ISNULL
    (
        pct.product_category_name_english,
        p.product_category_name
    ) AS product_category,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    COUNT(*) AS total_items_sold,

    CAST
    (
        SUM(oi.price)
        AS DECIMAL(18,2)
    ) AS product_revenue,

    CAST
    (
        SUM(oi.freight_value)
        AS DECIMAL(18,2)
    ) AS freight_revenue,

    CAST
    (
        SUM(oi.price + oi.freight_value)
        AS DECIMAL(18,2)
    ) AS gross_revenue,

    CAST
    (
        AVG(oi.price)
        AS DECIMAL(18,2)
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

    ISNULL
    (
        pct.product_category_name_english,
        p.product_category_name
    );
GO