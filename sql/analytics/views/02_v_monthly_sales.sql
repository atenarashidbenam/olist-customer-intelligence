USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_monthly_sales
AS

SELECT
    DATEFROMPARTS
    (
        YEAR(o.order_purchase_timestamp),
        MONTH(o.order_purchase_timestamp),
        1
    ) AS sales_month,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT c.customer_unique_id) AS total_customers,

    SUM(oi.price) AS product_revenue,

    SUM(oi.freight_value) AS freight_revenue,

    SUM(oi.price + oi.freight_value) AS gross_revenue,

    CAST
    (
        SUM(oi.price + oi.freight_value)
        / NULLIF(COUNT(DISTINCT o.order_id), 0)
        AS DECIMAL(18, 2)
    ) AS average_order_value

FROM core.orders AS o

INNER JOIN core.customers AS c
    ON o.customer_id = c.customer_id

INNER JOIN core.order_items AS oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    DATEFROMPARTS
    (
        YEAR(o.order_purchase_timestamp),
        MONTH(o.order_purchase_timestamp),
        1
    );
GO