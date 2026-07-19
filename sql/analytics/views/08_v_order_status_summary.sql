USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_order_status_summary
AS

SELECT

    order_status,

    COUNT(*) AS total_orders,

    CAST
    (
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER()
        AS DECIMAL(5,2)
    ) AS percentage_of_orders

FROM core.orders

GROUP BY order_status;
GO