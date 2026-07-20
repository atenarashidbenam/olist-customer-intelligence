/*
=========================================================
View Name :
analytics.v_executive_dashboard

Purpose :
Provide a single-row summary of the main business KPIs
for executive reporting and Power BI KPI cards.

Business Scope :
Only delivered orders are included in sales, customer,
review, delivery, and repeat-purchase KPIs.

Author :
Atena Rashidbenam

Project :
Olist Customer Intelligence Platform
=========================================================
*/

USE OlistCustomerIntelligence;
GO


CREATE OR ALTER VIEW analytics.v_executive_dashboard
AS

WITH delivered_orders AS
(
    SELECT
        o.order_id,
        o.customer_id,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date
    FROM core.orders AS o
    WHERE o.order_status = 'delivered'
),


/*-------------------------------------------------------
Calculate the financial value of each delivered order.

One row is created for each order to ensure that
Average Order Value is calculated correctly.
-------------------------------------------------------*/

order_totals AS
(
    SELECT
        do.order_id,
        do.customer_id,

        SUM(oi.price) AS product_revenue,

        SUM(oi.freight_value) AS freight_revenue,

        SUM(oi.price + oi.freight_value) AS gross_order_value,

        COUNT(*) AS total_items

    FROM delivered_orders AS do

    INNER JOIN core.order_items AS oi
        ON do.order_id = oi.order_id

    GROUP BY
        do.order_id,
        do.customer_id
),


/*-------------------------------------------------------
Sales and order KPIs
-------------------------------------------------------*/

sales_kpis AS
(
    SELECT
        COUNT(*) AS total_delivered_orders,

        SUM(total_items) AS total_items_sold,

        CAST
        (
            SUM(product_revenue)
            AS DECIMAL(18,2)
        ) AS total_product_revenue,

        CAST
        (
            SUM(freight_revenue)
            AS DECIMAL(18,2)
        ) AS total_freight_revenue,

        CAST
        (
            SUM(gross_order_value)
            AS DECIMAL(18,2)
        ) AS total_gross_revenue,

        CAST
        (
            AVG(gross_order_value)
            AS DECIMAL(18,2)
        ) AS average_order_value

    FROM order_totals
),


/*-------------------------------------------------------
Customer KPIs

Only customers with at least one delivered order
are included.
-------------------------------------------------------*/

customer_order_counts AS
(
    SELECT
        c.customer_unique_id,

        COUNT(DISTINCT do.order_id) AS delivered_order_count

    FROM delivered_orders AS do

    INNER JOIN core.customers AS c
        ON do.customer_id = c.customer_id

    GROUP BY
        c.customer_unique_id
),


customer_kpis AS
(
    SELECT
        COUNT(*) AS total_customers,

        SUM
        (
            CASE
                WHEN delivered_order_count > 1
                THEN 1
                ELSE 0
            END
        ) AS repeat_customers,

        CAST
        (
            SUM
            (
                CASE
                    WHEN delivered_order_count > 1
                    THEN 1.0
                    ELSE 0.0
                END
            )
            * 100.0
            / NULLIF(COUNT(*), 0)

            AS DECIMAL(6,2)
        ) AS repeat_customer_rate

    FROM customer_order_counts
),


/*-------------------------------------------------------
Review KPIs

Only reviews belonging to delivered orders
are included.
-------------------------------------------------------*/

review_kpis AS
(
    SELECT
        CAST
        (
            AVG(CAST(r.review_score AS DECIMAL(10,2)))
            AS DECIMAL(4,2)
        ) AS average_review_score,

        CAST
        (
            SUM
            (
                CASE
                    WHEN r.review_score >= 4
                    THEN 1.0
                    ELSE 0.0
                END
            )
            * 100.0
            / NULLIF(COUNT(*), 0)

            AS DECIMAL(6,2)
        ) AS positive_review_rate

    FROM delivered_orders AS do

    INNER JOIN core.order_reviews AS r
        ON do.order_id = r.order_id
),


/*-------------------------------------------------------
Delivery KPIs

Orders without a valid delivery date are excluded
from time-based delivery calculations.
-------------------------------------------------------*/

delivery_kpis AS
(
    SELECT
        CAST
        (
            AVG
            (
                CAST
                (
                    DATEDIFF
                    (
                        DAY,
                        do.order_purchase_timestamp,
                        do.order_delivered_customer_date
                    )
                    AS DECIMAL(10,2)
                )
            )
            AS DECIMAL(10,2)
        ) AS average_delivery_days,

        CAST
        (
            SUM
            (
                CASE
                    WHEN do.order_delivered_customer_date
                         <= do.order_estimated_delivery_date
                    THEN 1.0
                    ELSE 0.0
                END
            )
            * 100.0
            / NULLIF(COUNT(*), 0)

            AS DECIMAL(6,2)
        ) AS on_time_delivery_rate

    FROM delivered_orders AS do

    WHERE do.order_delivered_customer_date IS NOT NULL
      AND do.order_estimated_delivery_date IS NOT NULL
)


SELECT
    s.total_delivered_orders,

    c.total_customers,

    c.repeat_customers,

    s.total_items_sold,

    s.total_product_revenue,

    s.total_freight_revenue,

    s.total_gross_revenue,

    s.average_order_value,

    r.average_review_score,

    r.positive_review_rate,

    d.average_delivery_days,

    d.on_time_delivery_rate,

    c.repeat_customer_rate

FROM sales_kpis AS s

CROSS JOIN customer_kpis AS c

CROSS JOIN review_kpis AS r

CROSS JOIN delivery_kpis AS d;
GO