/*

Purpose :
Create nonclustered indexes to improve the performance
of analytics views and Power BI queries.

=========================================================
*/

USE OlistCustomerIntelligence;
GO


/*=======================================================
1. Orders Index
Supports:
- Monthly sales analysis
- Customer analysis
- Delivery analysis
- Order status analysis
=======================================================*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_orders_status_purchase_date'
      AND object_id = OBJECT_ID('core.orders')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_orders_status_purchase_date
    ON core.orders
    (
        order_status,
        order_purchase_timestamp
    )
    INCLUDE
    (
        customer_id,
        order_delivered_customer_date,
        order_estimated_delivery_date
    );
END;
GO


/*=======================================================
2. Order Items Index
Supports:
- Revenue calculations
- Product performance
- Seller performance
=======================================================*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_order_items_order_id'
      AND object_id = OBJECT_ID('core.order_items')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_order_items_order_id
    ON core.order_items
    (
        order_id
    )
    INCLUDE
    (
        product_id,
        seller_id,
        price,
        freight_value
    );
END;
GO


/*=======================================================
3. Product Index
Supports:
- Product and category analysis
=======================================================*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_products_category_name'
      AND object_id = OBJECT_ID('core.products')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_products_category_name
    ON core.products
    (
        product_category_name
    )
    INCLUDE
    (
        product_id
    );
END;
GO


/*=======================================================
4. Customer Index
Supports:
- Customer purchase history
- Repeat customer analysis
- RFM analysis
=======================================================*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_customers_unique_id'
      AND object_id = OBJECT_ID('core.customers')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_customers_unique_id
    ON core.customers
    (
        customer_unique_id
    )
    INCLUDE
    (
        customer_id,
        customer_city,
        customer_state
    );
END;
GO


/*=======================================================
5. Seller Index
Supports:
- Seller performance analysis
=======================================================*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_sellers_location'
      AND object_id = OBJECT_ID('core.sellers')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_sellers_location
    ON core.sellers
    (
        seller_state,
        seller_city
    )
    INCLUDE
    (
        seller_id
    );
END;
GO


/*=======================================================
6. Reviews Index
Supports:
- Review analysis
- Customer satisfaction KPIs
=======================================================*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_order_reviews_order_id'
      AND object_id = OBJECT_ID('core.order_reviews')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_order_reviews_order_id
    ON core.order_reviews
    (
        order_id
    )
    INCLUDE
    (
        review_score
    );
END;
GO


/*=======================================================
7. Payments Index
Supports:
- Payment and revenue analysis
=======================================================*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_order_payments_order_id'
      AND object_id = OBJECT_ID('core.order_payments')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_order_payments_order_id
    ON core.order_payments
    (
        order_id
    )
    INCLUDE
    (
        payment_type,
        payment_installments,
        payment_value
    );
END;
GO