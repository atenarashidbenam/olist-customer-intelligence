USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.order_payments', 'U') IS NULL
BEGIN
    CREATE TABLE staging.order_payments
    (
        order_id              VARCHAR(50),
        payment_sequential    INT,
        payment_type          VARCHAR(30),
        payment_installments  INT,
        payment_value         DECIMAL(12, 2)
    );
END;
GO