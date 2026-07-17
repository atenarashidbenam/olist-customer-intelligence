USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.orders', 'U') IS NULL
BEGIN
    CREATE TABLE staging.orders
    (
        order_id                       VARCHAR(50),
        customer_id                    VARCHAR(50),
        order_status                   VARCHAR(30),
        order_purchase_timestamp       DATETIME2,
        order_approved_at              DATETIME2,
        order_delivered_carrier_date   DATETIME2,
        order_delivered_customer_date  DATETIME2,
        order_estimated_delivery_date  DATETIME2
    );
END;
GO