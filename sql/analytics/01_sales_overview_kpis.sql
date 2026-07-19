USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_product_revenue,
    SUM(oi.freight_value) AS total_freight_revenue,
    SUM(oi.price + oi.freight_value) AS total_gross_revenue,
    AVG(oi.price) AS average_item_price
FROM core.orders AS o
INNER JOIN core.order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';
GO

SELECT
    SUM(order_total) / COUNT(*) AS average_order_value
FROM
(
    SELECT
        oi.order_id,
        SUM(oi.price + oi.freight_value) AS order_total
    FROM core.order_items AS oi
    INNER JOIN core.orders AS o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY oi.order_id
) AS delivered_orders;
GO

SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS product_revenue,
    SUM(oi.freight_value) AS freight_revenue,
    SUM(oi.price + oi.freight_value) AS gross_revenue
FROM core.orders AS o
INNER JOIN core.order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)
ORDER BY
    order_year,
    order_month;
GO
WITH monthly_revenue AS
(
    SELECT
        DATEFROMPARTS
        (
            YEAR(o.order_purchase_timestamp),
            MONTH(o.order_purchase_timestamp),
            1
        ) AS revenue_month,

        COUNT(DISTINCT o.order_id) AS total_orders,

        SUM(oi.price) AS product_revenue,

        SUM(oi.freight_value) AS freight_revenue,

        SUM(oi.price + oi.freight_value) AS gross_revenue
    FROM core.orders AS o
    INNER JOIN core.order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        DATEFROMPARTS
        (
            YEAR(o.order_purchase_timestamp),
            MONTH(o.order_purchase_timestamp),
            1
        )
),

monthly_revenue_with_previous AS
(
    SELECT
        revenue_month,
        total_orders,
        product_revenue,
        freight_revenue,
        gross_revenue,

        LAG(gross_revenue) OVER
        (
            ORDER BY revenue_month
        ) AS previous_month_gross_revenue
    FROM monthly_revenue
)

SELECT
    revenue_month,
    total_orders,
    product_revenue,
    freight_revenue,
    gross_revenue,
    previous_month_gross_revenue,

    ROUND
    (
        (
            gross_revenue - previous_month_gross_revenue
        )
        * 100.0
        / NULLIF(previous_month_gross_revenue, 0),
        2
    ) AS monthly_revenue_growth_percentage
FROM monthly_revenue_with_previous
ORDER BY revenue_month;
GO

WITH monthly_revenue AS
(
    SELECT
        DATEFROMPARTS
        (
            YEAR(o.order_purchase_timestamp),
            MONTH(o.order_purchase_timestamp),
            1
        ) AS revenue_month,

        COUNT(DISTINCT o.order_id) AS total_orders,

        SUM(oi.price) AS product_revenue,

        SUM(oi.freight_value) AS freight_revenue,

        SUM(oi.price + oi.freight_value) AS gross_revenue
    FROM core.orders AS o
    INNER JOIN core.order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        DATEFROMPARTS
        (
            YEAR(o.order_purchase_timestamp),
            MONTH(o.order_purchase_timestamp),
            1
        )
),

monthly_revenue_with_previous AS
(
    SELECT
        revenue_month,
        total_orders,
        product_revenue,
        freight_revenue,
        gross_revenue,

        LAG(gross_revenue) OVER
        (
            ORDER BY revenue_month
        ) AS previous_month_gross_revenue
    FROM monthly_revenue
)

SELECT
    revenue_month,
    total_orders,
    product_revenue,
    freight_revenue,
    gross_revenue,
    previous_month_gross_revenue,

    ROUND
    (
        (
            gross_revenue - previous_month_gross_revenue
        )
        * 100.0
        / NULLIF(previous_month_gross_revenue, 0),
        2
    ) AS monthly_revenue_growth_percentage
FROM monthly_revenue_with_previous
ORDER BY revenue_month;
GO