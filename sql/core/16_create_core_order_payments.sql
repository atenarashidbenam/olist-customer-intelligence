USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.order_payments', 'U') IS NULL
BEGIN
    CREATE TABLE core.order_payments
    (
        order_id VARCHAR(32) NOT NULL,
        payment_sequential INT NOT NULL,
        payment_type VARCHAR(20) NOT NULL,
        payment_installments INT NOT NULL,
        payment_value DECIMAL(10, 2) NOT NULL,

        CONSTRAINT PK_core_order_payments
            PRIMARY KEY (order_id, payment_sequential),

        CONSTRAINT FK_core_order_payments_orders
            FOREIGN KEY (order_id)
            REFERENCES core.orders(order_id)
    );
END;
GO