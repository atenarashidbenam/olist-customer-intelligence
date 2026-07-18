USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.order_reviews;
GO

INSERT INTO core.order_reviews
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
SELECT
    LTRIM(RTRIM(review_id)),
    LTRIM(RTRIM(order_id)),
    review_score,
    NULLIF(LTRIM(RTRIM(review_comment_title)), ''),
    NULLIF(LTRIM(RTRIM(review_comment_message)), ''),
    review_creation_date,
    review_answer_timestamp
FROM staging.order_reviews;
GO

SELECT
    COUNT(*) AS core_order_review_row_count
FROM core.order_reviews;
GO