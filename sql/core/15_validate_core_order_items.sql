USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_order_ids,
    COUNT(DISTINCT product_id) AS distinct_product_ids,
    COUNT(DISTINCT seller_id) AS distinct_seller_ids
FROM core.order_items;
GO

SELECT
    SUM(
        CASE
            WHEN order_id IS NULL
                 OR LTRIM(RTRIM(order_id)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_order_id_count,

    SUM(
        CASE
            WHEN order_item_id IS NULL
                 OR order_item_id <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_order_item_id_count,

    SUM(
        CASE
            WHEN product_id IS NULL
                 OR LTRIM(RTRIM(product_id)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_product_id_count,

    SUM(
        CASE
            WHEN seller_id IS NULL
                 OR LTRIM(RTRIM(seller_id)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_seller_id_count,

    SUM(
        CASE
            WHEN shipping_limit_date IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_shipping_limit_date_count,

    SUM(
        CASE
            WHEN price IS NULL
                 OR price <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_price_count,

    SUM(
        CASE
            WHEN freight_value IS NULL
                 OR freight_value < 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_freight_value_count
FROM core.order_items;
GO

SELECT
    order_id,
    order_item_id,
    COUNT(*) AS duplicate_count
FROM core.order_items
GROUP BY
    order_id,
    order_item_id
HAVING COUNT(*) > 1;
GO

SELECT
    SUM(
        CASE
            WHEN o.order_id IS NULL
            THEN 1
            ELSE 0
        END
    ) AS orphan_order_count,

    SUM(
        CASE
            WHEN p.product_id IS NULL
            THEN 1
            ELSE 0
        END
    ) AS orphan_product_count,

    SUM(
        CASE
            WHEN s.seller_id IS NULL
            THEN 1
            ELSE 0
        END
    ) AS orphan_seller_count
FROM core.order_items oi
LEFT JOIN core.orders o
    ON oi.order_id = o.order_id
LEFT JOIN core.products p
    ON oi.product_id = p.product_id
LEFT JOIN core.sellers s
    ON oi.seller_id = s.seller_id;
GO

SELECT
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price,
    AVG(price) AS average_price,
    MIN(freight_value) AS minimum_freight_value,
    MAX(freight_value) AS maximum_freight_value,
    AVG(freight_value) AS average_freight_value
FROM core.order_items;
GO

SELECT TOP 20
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
FROM core.order_items
ORDER BY price DESC;
GO