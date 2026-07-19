USE OlistCustomerIntelligence;
GO

/*=========================================================
Customer Analysis
=========================================================*/
/*=========================================================
Customer Overview KPIs
=========================================================*/

SELECT
    COUNT(DISTINCT c.customer_unique_id) AS total_unique_customers,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'delivered'
        THEN c.customer_unique_id
    END) AS customers_with_delivered_orders,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'delivered'
        THEN o.order_id
    END) AS delivered_orders
FROM core.customers AS c
INNER JOIN core.orders AS o
    ON c.customer_id = o.customer_id;
GO


WITH delivered_customer_orders AS
(
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS delivered_order_count
    FROM core.customers AS c
    INNER JOIN core.orders AS o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    COUNT(*) AS customers_with_delivered_orders,

    SUM(
        CASE
            WHEN delivered_order_count = 1
            THEN 1
            ELSE 0
        END
    ) AS one_time_customers,

    SUM(
        CASE
            WHEN delivered_order_count > 1
            THEN 1
            ELSE 0
        END
    ) AS repeat_customers,

    ROUND(
        SUM(
            CASE
                WHEN delivered_order_count > 1
                THEN 1.0
                ELSE 0.0
            END
        )
        * 100.0
        / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_customer_rate_percentage

FROM delivered_customer_orders;
GO
/*=========================================================
Monthly New Customers
=========================================================*/

WITH first_purchase AS
(
    SELECT
        c.customer_unique_id,

        MIN(o.order_purchase_timestamp) AS first_purchase_date

    FROM core.customers AS c

    INNER JOIN core.orders AS o
        ON c.customer_id = o.customer_id

    WHERE o.order_status = 'delivered'

    GROUP BY
        c.customer_unique_id
)

SELECT

    DATEFROMPARTS
    (
        YEAR(first_purchase_date),
        MONTH(first_purchase_date),
        1
    ) AS customer_month,

    COUNT(*) AS new_customers

FROM first_purchase

GROUP BY

    DATEFROMPARTS
    (
        YEAR(first_purchase_date),
        MONTH(first_purchase_date),
        1
    )

ORDER BY customer_month;
GO
/*=========================================================
Customer Lifetime Value (CLV)
=========================================================*/

WITH customer_revenue AS
(
    SELECT
        c.customer_unique_id,

        COUNT(DISTINCT o.order_id) AS total_orders,

        SUM(oi.price) AS product_revenue,

        SUM(oi.freight_value) AS freight_revenue,

        SUM(oi.price + oi.freight_value) AS gross_revenue

    FROM core.customers AS c

    INNER JOIN core.orders AS o
        ON c.customer_id = o.customer_id

    INNER JOIN core.order_items AS oi
        ON o.order_id = oi.order_id

    WHERE o.order_status = 'delivered'

    GROUP BY
        c.customer_unique_id
)

SELECT
    customer_unique_id,

    total_orders,

    product_revenue,

    freight_revenue,

    gross_revenue,

    ROUND
    (
        gross_revenue / total_orders,
        2
    ) AS average_order_value

FROM customer_revenue

ORDER BY gross_revenue DESC;
GO
/*=========================================================
RFM Base Metrics
=========================================================*/

SELECT
    c.customer_unique_id,

    MAX(o.order_purchase_timestamp) AS last_purchase_date,

    COUNT(DISTINCT o.order_id) AS frequency,

    SUM(oi.price + oi.freight_value) AS monetary

FROM core.customers AS c

INNER JOIN core.orders AS o
    ON c.customer_id = o.customer_id

INNER JOIN core.order_items AS oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    c.customer_unique_id

ORDER BY
    monetary DESC;
GO