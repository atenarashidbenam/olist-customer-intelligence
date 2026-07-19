USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_delivery_performance
AS

SELECT

    o.order_id,

    c.customer_unique_id,

    o.order_purchase_timestamp,

    o.order_delivered_customer_date,

    o.order_estimated_delivery_date,

    DATEDIFF
    (
        DAY,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date
    ) AS delivery_days,

    DATEDIFF
    (
        DAY,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date
    ) AS delivery_difference_days,

    CASE

        WHEN o.order_delivered_customer_date IS NULL
        THEN 'Not Delivered'

        WHEN o.order_delivered_customer_date
             <= o.order_estimated_delivery_date
        THEN 'On Time'

        ELSE 'Late'

    END AS delivery_status

FROM core.orders AS o

INNER JOIN core.customers AS c
    ON o.customer_id = c.customer_id;
GO