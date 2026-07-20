USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_monthly_sales
AS

/*-------------------------------------------------------
One row per delivered order
-------------------------------------------------------*/
WITH order_totals AS
(
    SELECT
        o.order_id,

        DATEFROMPARTS
        (
            YEAR(o.order_purchase_timestamp),
            MONTH(o.order_purchase_timestamp),
            1
        ) AS sales_month,

        c.customer_unique_id,

        SUM(oi.price) AS product_revenue,

        SUM(oi.freight_value) AS freight_revenue,

        SUM(oi.price + oi.freight_value) AS gross_order_value

    FROM core.orders AS o

    INNER JOIN core.customers AS c
        ON o.customer_id = c.customer_id

    INNER JOIN core.order_items AS oi
        ON o.order_id = oi.order_id

    WHERE o.order_status = 'delivered'

    GROUP BY
        o.order_id,
        c.customer_unique_id,
        DATEFROMPARTS
        (
            YEAR(o.order_purchase_timestamp),
            MONTH(o.order_purchase_timestamp),
            1
        )
)

SELECT
    sales_month,

    COUNT(*) AS total_orders,

    COUNT(DISTINCT customer_unique_id) AS total_customers,

    CAST
    (
        SUM(product_revenue)
        AS DECIMAL(18,2)
    ) AS product_revenue,

    CAST
    (
        SUM(freight_revenue)
        AS DECIMAL(18,2)
    ) AS freight_revenue,

    CAST
    (
        SUM(gross_order_value)
        AS DECIMAL(18,2)
    ) AS gross_revenue,

    CAST
    (
        AVG(gross_order_value)
        AS DECIMAL(18,2)
    ) AS average_order_value

FROM order_totals

GROUP BY
    sales_month;
GO