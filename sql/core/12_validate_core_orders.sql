USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_order_ids,
    COUNT(DISTINCT customer_id) AS distinct_customer_ids
FROM core.orders;
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
            WHEN customer_id IS NULL
                 OR LTRIM(RTRIM(customer_id)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_customer_id_count,

    SUM(
        CASE
            WHEN order_status IS NULL
                 OR LTRIM(RTRIM(order_status)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_order_status_count,

    SUM(
        CASE
            WHEN order_purchase_timestamp IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_purchase_timestamp_count,

    SUM(
        CASE
            WHEN order_approved_at IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_approved_at_count,

    SUM(
        CASE
            WHEN order_delivered_carrier_date IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_carrier_date_count,

    SUM(
        CASE
            WHEN order_delivered_customer_date IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_customer_delivery_date_count,

    SUM(
        CASE
            WHEN order_estimated_delivery_date IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_estimated_delivery_date_count
FROM core.orders;
GO

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM core.orders
GROUP BY order_id
HAVING COUNT(*) > 1;
GO

SELECT
    order_status,
    COUNT(*) AS order_count
FROM core.orders
GROUP BY order_status
ORDER BY order_count DESC;
GO

SELECT
    SUM(
        CASE
            WHEN order_approved_at IS NOT NULL
                 AND order_approved_at < order_purchase_timestamp
            THEN 1
            ELSE 0
        END
    ) AS approved_before_purchase_count,

    SUM(
        CASE
            WHEN order_delivered_carrier_date IS NOT NULL
                 AND order_approved_at IS NOT NULL
                 AND order_delivered_carrier_date < order_approved_at
            THEN 1
            ELSE 0
        END
    ) AS carrier_before_approval_count,

    SUM(
        CASE
            WHEN order_delivered_customer_date IS NOT NULL
                 AND order_delivered_carrier_date IS NOT NULL
                 AND order_delivered_customer_date < order_delivered_carrier_date
            THEN 1
            ELSE 0
        END
    ) AS customer_delivery_before_carrier_count
FROM core.orders;
GO

SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM core.orders
WHERE
    (
        order_approved_at IS NOT NULL
        AND order_approved_at < order_purchase_timestamp
    )
    OR
    (
        order_delivered_carrier_date IS NOT NULL
        AND order_approved_at IS NOT NULL
        AND order_delivered_carrier_date < order_approved_at
    )
    OR
    (
        order_delivered_customer_date IS NOT NULL
        AND order_delivered_carrier_date IS NOT NULL
        AND order_delivered_customer_date < order_delivered_carrier_date
    )
ORDER BY order_purchase_timestamp;
GO