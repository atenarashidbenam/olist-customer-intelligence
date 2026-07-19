USE OlistCustomerIntelligence;
GO

SELECT TOP (10)
    oi.product_id,
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS product_category,
    COUNT(*) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders_count,
    SUM(oi.price) AS product_revenue,
    SUM(oi.freight_value) AS freight_revenue,
    SUM(oi.price + oi.freight_value) AS gross_revenue,
    AVG(oi.price) AS average_selling_price
FROM core.order_items AS oi
INNER JOIN core.orders AS o
    ON oi.order_id = o.order_id
INNER JOIN core.products AS p
    ON oi.product_id = p.product_id
LEFT JOIN core.product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY
    oi.product_id,
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'unknown'
    )
ORDER BY
    product_revenue DESC;
GO
SELECT TOP (10)
    oi.product_id,
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS product_category,
    COUNT(*) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders_count,
    SUM(oi.price) AS product_revenue,
    AVG(oi.price) AS average_selling_price
FROM core.order_items AS oi
INNER JOIN core.orders AS o
    ON oi.order_id = o.order_id
INNER JOIN core.products AS p
    ON oi.product_id = p.product_id
LEFT JOIN core.product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY
    oi.product_id,
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'unknown'
    )
ORDER BY
    units_sold DESC,
    product_revenue DESC;
GO
SELECT
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS product_category,

    COUNT(*) AS units_sold,

    COUNT(DISTINCT oi.order_id) AS orders_count,

    SUM(oi.price) AS product_revenue,

    SUM(oi.freight_value) AS freight_revenue,

    SUM(oi.price + oi.freight_value) AS gross_revenue,

    AVG(oi.price) AS average_item_price

FROM core.order_items AS oi

INNER JOIN core.orders AS o
    ON oi.order_id = o.order_id

INNER JOIN core.products AS p
    ON oi.product_id = p.product_id

LEFT JOIN core.product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

WHERE o.order_status = 'delivered'

GROUP BY
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'unknown'
    )

ORDER BY
    gross_revenue DESC;
GO
WITH category_revenue AS
(
    SELECT
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'unknown'
        ) AS product_category,

        SUM(oi.price) AS product_revenue,

        SUM(oi.freight_value) AS freight_revenue,

        SUM(oi.price + oi.freight_value) AS gross_revenue

    FROM core.order_items AS oi

    INNER JOIN core.orders AS o
        ON oi.order_id = o.order_id

    INNER JOIN core.products AS p
        ON oi.product_id = p.product_id

    LEFT JOIN core.product_category_translation AS pct
        ON p.product_category_name = pct.product_category_name

    WHERE o.order_status = 'delivered'

    GROUP BY
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'unknown'
        )
)

SELECT
    product_category,
    product_revenue,
    freight_revenue,
    gross_revenue,

    ROUND
    (
        gross_revenue * 100.0
        / SUM(gross_revenue) OVER (),
        2
    ) AS gross_revenue_share_percentage

FROM category_revenue

ORDER BY
    gross_revenue DESC;
GO
/*=========================================================
Pareto Analysis (80/20)
=========================================================*/

WITH category_revenue AS
(
    SELECT
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'unknown'
        ) AS product_category,

        SUM(oi.price + oi.freight_value) AS gross_revenue

    FROM core.order_items AS oi

    INNER JOIN core.orders AS o
        ON oi.order_id = o.order_id

    INNER JOIN core.products AS p
        ON oi.product_id = p.product_id

    LEFT JOIN core.product_category_translation AS pct
        ON p.product_category_name = pct.product_category_name

    WHERE o.order_status = 'delivered'

    GROUP BY
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'unknown'
        )
),

pareto AS
(
    SELECT
        product_category,
        gross_revenue,

        SUM(gross_revenue) OVER
        (
            ORDER BY gross_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue,

        SUM(gross_revenue) OVER () AS total_revenue

    FROM category_revenue
)

SELECT
    product_category,

    gross_revenue,

    cumulative_revenue,

    ROUND
    (
        cumulative_revenue * 100.0
        / total_revenue,
        2
    ) AS cumulative_percentage

FROM pareto

ORDER BY gross_revenue DESC;
GO