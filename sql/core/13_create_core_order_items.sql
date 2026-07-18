USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.order_items', 'U') IS NULL
BEGIN
    CREATE TABLE core.order_items
    (
        order_id VARCHAR(32) NOT NULL,
        order_item_id INT NOT NULL,
        product_id VARCHAR(32) NOT NULL,
        seller_id VARCHAR(32) NOT NULL,
        shipping_limit_date DATETIME2 NOT NULL,
        price DECIMAL(10,2) NOT NULL,
        freight_value DECIMAL(10,2) NOT NULL,

        CONSTRAINT PK_core_order_items
            PRIMARY KEY (order_id, order_item_id),

        CONSTRAINT FK_order_items_orders
            FOREIGN KEY (order_id)
            REFERENCES core.orders(order_id),

        CONSTRAINT FK_order_items_products
            FOREIGN KEY (product_id)
            REFERENCES core.products(product_id),

        CONSTRAINT FK_order_items_sellers
            FOREIGN KEY (seller_id)
            REFERENCES core.sellers(seller_id)
    );
END;
GO