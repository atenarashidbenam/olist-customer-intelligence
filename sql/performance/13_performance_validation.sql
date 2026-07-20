USE OlistCustomerIntelligence;
GO

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO
SELECT

    YEAR(order_purchase_timestamp) AS sales_year,

    MONTH(order_purchase_timestamp) AS sales_month,

    COUNT(*) AS total_orders

FROM core.orders

WHERE order_status = 'delivered'

GROUP BY

    YEAR(order_purchase_timestamp),

    MONTH(order_purchase_timestamp)

ORDER BY

    sales_year,

    sales_month;
GO