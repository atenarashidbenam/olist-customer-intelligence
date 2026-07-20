USE OlistCustomerIntelligence;
GO


/*=======================================================
1. Check all views created in the analytics schema
=======================================================*/

SELECT
    s.name AS schema_name,
    v.name AS view_name,
    v.create_date,
    v.modify_date
FROM sys.views AS v

INNER JOIN sys.schemas AS s
    ON v.schema_id = s.schema_id

WHERE s.name = 'analytics'

ORDER BY v.name;
GO


/*=======================================================
2. Validate Executive Dashboard
Expected result: exactly one row
=======================================================*/

SELECT
    COUNT(*) AS executive_dashboard_row_count
FROM analytics.v_executive_dashboard;
GO


SELECT *
FROM analytics.v_executive_dashboard;
GO


/*=======================================================
3. Revenue Reconciliation
Expected difference: 0
=======================================================*/

SELECT

    ed.gross_revenue AS executive_dashboard_revenue,

    ms.total_monthly_revenue,

    CAST
    (
        ed.gross_revenue - ms.total_monthly_revenue
        AS DECIMAL(18,2)
    ) AS revenue_difference

FROM analytics.v_executive_dashboard AS ed

CROSS JOIN
(
    SELECT
        SUM(gross_revenue) AS total_monthly_revenue
    FROM analytics.v_monthly_sales
) AS ms;
GO


/*=======================================================
4. Validate Order Status Percentages
Expected result: approximately 100%
=======================================================*/

SELECT *
FROM analytics.v_order_status_summary
ORDER BY total_orders DESC;
GO


SELECT
    SUM(percentage_of_orders) AS total_percentage
FROM analytics.v_order_status_summary;
GO


/*=======================================================
5. Validate Review Score Distribution
Expected review scores: 1 to 5
Expected total percentage: approximately 100%
=======================================================*/

SELECT *
FROM analytics.v_review_analysis
ORDER BY review_score;
GO


SELECT
    MIN(review_score) AS minimum_review_score,
    MAX(review_score) AS maximum_review_score,
    SUM(total_reviews) AS total_reviews,
    SUM(percentage_of_reviews) AS total_percentage
FROM analytics.v_review_analysis;
GO


/*=======================================================
6. Validate Delivery Performance
=======================================================*/

SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM analytics.v_delivery_performance

GROUP BY delivery_status

ORDER BY total_orders DESC;
GO


SELECT
    COUNT(*) AS invalid_delivery_records
FROM analytics.v_delivery_performance

WHERE delivery_status IN ('On Time', 'Late')
  AND order_delivered_customer_date IS NULL;
GO


/*=======================================================
7. Validate Customer RFM Scores
Expected score range: 1 to 5
=======================================================*/

SELECT
    MIN(recency_score) AS minimum_recency_score,
    MAX(recency_score) AS maximum_recency_score,

    MIN(frequency_score) AS minimum_frequency_score,
    MAX(frequency_score) AS maximum_frequency_score,

    MIN(monetary_score) AS minimum_monetary_score,
    MAX(monetary_score) AS maximum_monetary_score

FROM analytics.v_customer_rfm_scores;
GO


/*=======================================================
8. Validate Customer Segments
=======================================================*/

SELECT
    customer_segment,
    COUNT(*) AS total_customers,

    CAST
    (
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(6,2)
    ) AS percentage_of_customers

FROM analytics.v_customer_segments

GROUP BY customer_segment

ORDER BY total_customers DESC;
GO


/*=======================================================
9. Validate Monthly Sales
=======================================================*/

SELECT
    MIN(sales_month) AS first_sales_month,
    MAX(sales_month) AS last_sales_month,
    SUM(total_orders) AS total_orders,
    SUM(total_customers) AS total_customer_records,
    SUM(product_revenue) AS total_product_revenue,
    SUM(freight_revenue) AS total_freight_revenue,
    SUM(gross_revenue) AS total_gross_revenue

FROM analytics.v_monthly_sales;
GO


/*=======================================================
10. Validate Product Performance
=======================================================*/

SELECT
    COUNT(*) AS total_products,
    SUM(total_orders) AS total_product_order_records,
    SUM(total_items_sold) AS total_items_sold,
    SUM(product_revenue) AS total_product_revenue

FROM analytics.v_product_performance;
GO


/*=======================================================
11. Validate Seller Performance
=======================================================*/

SELECT
    COUNT(*) AS total_sellers,
    SUM(total_orders) AS total_seller_order_records,
    SUM(product_revenue) AS total_product_revenue,
    SUM(freight_revenue) AS total_freight_revenue,
    SUM(gross_revenue) AS total_gross_revenue

FROM analytics.v_seller_performance;
GO