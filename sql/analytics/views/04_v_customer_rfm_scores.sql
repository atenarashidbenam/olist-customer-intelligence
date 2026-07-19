USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_customer_rfm_scores
AS

WITH reference_date AS
(
    SELECT
        DATEADD(
            DAY,
            1,
            MAX(order_purchase_timestamp)
        ) AS analysis_date
    FROM core.orders
    WHERE order_status = 'delivered'
),

rfm_metrics AS
(
    SELECT
        r.customer_unique_id,

        r.last_purchase_date,

        DATEDIFF(
            DAY,
            r.last_purchase_date,
            d.analysis_date
        ) AS recency_days,

        r.frequency,

        r.product_revenue,

        r.freight_revenue,

        r.monetary

    FROM analytics.v_customer_rfm AS r

    CROSS JOIN reference_date AS d
),

rfm_scores AS
(
    SELECT
        customer_unique_id,

        last_purchase_date,

        recency_days,

        frequency,

        product_revenue,

        freight_revenue,

        monetary,

        NTILE(5) OVER (
            ORDER BY recency_days DESC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary ASC
        ) AS monetary_score

    FROM rfm_metrics
)

SELECT
    customer_unique_id,

    last_purchase_date,

    recency_days,

    frequency,

    product_revenue,

    freight_revenue,

    monetary,

    recency_score,

    frequency_score,

    monetary_score,

    CONCAT(
        recency_score,
        frequency_score,
        monetary_score
    ) AS rfm_score

FROM rfm_scores;
GO