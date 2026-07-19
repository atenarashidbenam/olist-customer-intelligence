USE OlistCustomerIntelligence;
GO

CREATE OR ALTER VIEW analytics.v_review_analysis
AS

SELECT

    r.review_score,

    COUNT(*) AS total_reviews,

    CAST
    (
        COUNT(*) * 100.0
        /
        SUM(COUNT(*)) OVER()
        AS DECIMAL(5,2)
    ) AS percentage_of_reviews

FROM core.order_reviews AS r

GROUP BY
    r.review_score;
GO