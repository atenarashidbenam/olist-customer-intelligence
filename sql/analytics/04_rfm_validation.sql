USE OlistCustomerIntelligence;
GO

SELECT
    frequency,
    COUNT(*) AS customer_count
FROM analytics.v_customer_rfm
GROUP BY frequency
ORDER BY frequency;
GO
SELECT
    MIN(monetary) AS min_value,
    AVG(monetary) AS avg_value,
    MAX(monetary) AS max_value
FROM analytics.v_customer_rfm;
GO
SELECT
    recency_score,
    frequency_score,
    monetary_score,
    COUNT(*) AS customers
FROM analytics.v_customer_rfm_scores
GROUP BY
    recency_score,
    frequency_score,
    monetary_score
ORDER BY
    recency_score,
    frequency_score,
    monetary_score;
GO
