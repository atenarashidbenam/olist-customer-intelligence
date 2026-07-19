USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_executive_dashboard
AS

WITH sales AS
(
    SELECT

        COUNT(DISTINCT o.order_id) AS total_orders,

        SUM(oi.price) AS product_revenue,

        SUM(oi.freight_value) AS freight_revenue,

        SUM(oi.price + oi.freight_value) AS gross_revenue,

        AVG(oi.price + oi.freight_value) AS average_item_value

    FROM core.orders o

    INNER JOIN core.order_items oi
        ON o.order_id = oi.order_id

    WHERE o.order_status='delivered'
),

customers AS
(
    SELECT

        COUNT(DISTINCT customer_unique_id) AS total_customers

    FROM core.customers
),

reviews AS
(
    SELECT

        AVG(CAST(review_score AS DECIMAL(10,2)))
            AS average_review_score

    FROM core.order_reviews
),

delivery AS
(
    SELECT

        AVG
        (
            CAST
            (
                DATEDIFF
                (
                    DAY,
                    order_purchase_timestamp,
                    order_delivered_customer_date
                )
                AS DECIMAL(10,2)
            )
        ) AS average_delivery_days

    FROM core.orders

    WHERE order_status='delivered'
),

repeat_rate AS
(
    SELECT

        CAST
        (
            SUM
            (
                CASE
                    WHEN total_orders>1 THEN 1.0
                    ELSE 0
                END
            )
            /
            COUNT(*)
            *100
            AS DECIMAL(10,2)
        ) AS repeat_customer_rate

    FROM
    (

        SELECT

            c.customer_unique_id,

            COUNT(DISTINCT o.order_id) AS total_orders

        FROM core.customers c

        INNER JOIN core.orders o

            ON c.customer_id=o.customer_id

        WHERE o.order_status='delivered'

        GROUP BY c.customer_unique_id

    ) t
)

SELECT

    s.total_orders,

    c.total_customers,

    s.product_revenue,

    s.freight_revenue,

    s.gross_revenue,

    s.average_item_value,

    r.average_review_score,

    d.average_delivery_days,

    rr.repeat_customer_rate

FROM sales s

CROSS JOIN customers c

CROSS JOIN reviews r

CROSS JOIN delivery d

CROSS JOIN repeat_rate rr;
GO