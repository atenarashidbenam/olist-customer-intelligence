USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.order_payments;
GO

INSERT INTO core.order_payments
(
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
SELECT
    LTRIM(RTRIM(order_id)),
    payment_sequential,
    LOWER(LTRIM(RTRIM(payment_type))),
    payment_installments,
    payment_value
FROM staging.order_payments;
GO

SELECT
    COUNT(*) AS core_order_payment_row_count
FROM core.order_payments;
GO