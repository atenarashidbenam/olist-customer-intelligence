USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.order_items', 'U') IS NULL
BEGIN
    CREATE TABLE staging.order_items
    (
        order_id             VARCHAR(50),
        order_item_id        INT,
        product_id           VARCHAR(50),
        seller_id            VARCHAR(50),
        shipping_limit_date  DATETIME2,
        price                DECIMAL(10,2),
        freight_value        DECIMAL(10,2)
    );
END;
GO