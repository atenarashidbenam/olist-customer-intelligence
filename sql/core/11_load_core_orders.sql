USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.orders;
GO

INSERT INTO core.orders
(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
SELECT
    LTRIM(RTRIM(order_id)),
    LTRIM(RTRIM(customer_id)),
    LOWER(LTRIM(RTRIM(order_status))),
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM staging.orders;
GO

SELECT
    COUNT(*) AS core_order_row_count
FROM core.orders;
GO