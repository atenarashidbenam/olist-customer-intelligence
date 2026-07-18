USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_order_ids
FROM core.order_payments;
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
            WHEN payment_sequential IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_payment_sequential_count,

    SUM(
        CASE
            WHEN payment_type IS NULL
                 OR LTRIM(RTRIM(payment_type)) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_payment_type_count,

    SUM(
        CASE
            WHEN payment_installments IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_installments_count,

    SUM(
        CASE
            WHEN payment_value IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_payment_value_count
FROM core.order_payments;
GO

SELECT
    order_id,
    payment_sequential,
    COUNT(*) AS duplicate_count
FROM core.order_payments
GROUP BY
    order_id,
    payment_sequential
HAVING COUNT(*) > 1;
GO

SELECT
    payment_type,
    COUNT(*) AS payment_count
FROM core.order_payments
GROUP BY payment_type
ORDER BY payment_count DESC;
GO

SELECT
    MIN(payment_value) AS minimum_payment,
    MAX(payment_value) AS maximum_payment,
    AVG(payment_value) AS average_payment
FROM core.order_payments;
GO

SELECT TOP (20)
    *
FROM core.order_payments
WHERE payment_value < 0
ORDER BY payment_value;
GO