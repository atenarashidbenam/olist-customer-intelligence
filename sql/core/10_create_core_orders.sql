USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.orders', 'U') IS NULL
BEGIN
    CREATE TABLE core.orders
    (
        order_id VARCHAR(32) NOT NULL,
        customer_id VARCHAR(32) NOT NULL,
        order_status VARCHAR(20) NOT NULL,
        order_purchase_timestamp DATETIME2 NOT NULL,
        order_approved_at DATETIME2 NULL,
        order_delivered_carrier_date DATETIME2 NULL,
        order_delivered_customer_date DATETIME2 NULL,
        order_estimated_delivery_date DATETIME2 NOT NULL,

        CONSTRAINT PK_core_orders
            PRIMARY KEY (order_id),

        CONSTRAINT FK_core_orders_customers
            FOREIGN KEY (customer_id)
            REFERENCES core.customers(customer_id)
    );
END;
GO