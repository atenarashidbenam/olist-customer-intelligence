USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.order_items;
GO

INSERT INTO core.order_items
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
SELECT
    LTRIM(RTRIM(order_id)),
    order_item_id,
    LTRIM(RTRIM(product_id)),
    LTRIM(RTRIM(seller_id)),
    shipping_limit_date,
    price,
    freight_value
FROM staging.order_items;
GO

SELECT
    COUNT(*) AS core_order_item_row_count
FROM core.order_items;
GO