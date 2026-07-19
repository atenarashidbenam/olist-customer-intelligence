USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_customer_segments
AS

SELECT

    customer_unique_id,

    recency_days,

    frequency,

    monetary,

    recency_score,

    frequency_score,

    monetary_score,

    rfm_score,

    CASE

        WHEN recency_score >= 4
         AND frequency_score >= 4
         AND monetary_score >= 4
        THEN 'Champions'

        WHEN recency_score >= 3
         AND frequency_score >= 4
        THEN 'Loyal Customers'

        WHEN recency_score >= 4
         AND frequency_score <= 2
        THEN 'Potential Loyalists'

        WHEN recency_score = 5
         AND frequency_score = 1
        THEN 'New Customers'

        WHEN recency_score <= 2
         AND frequency_score >= 4
        THEN 'At Risk'

        WHEN recency_score = 1
         AND frequency_score >= 4
        THEN 'Cannot Lose Them'

        WHEN recency_score = 1
         AND frequency_score <= 2
        THEN 'Lost'

        ELSE 'Others'

    END AS customer_segment

FROM analytics.v_customer_rfm_scores;
GO