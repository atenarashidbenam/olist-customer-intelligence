USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT review_id) AS distinct_review_ids,
    COUNT(DISTINCT order_id) AS distinct_order_ids
FROM core.order_reviews;
GO

SELECT
    SUM(
        CASE
            WHEN review_id IS NULL
                 OR LTRIM(RTRIM(review_id)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_review_id_count,

    SUM(
        CASE
            WHEN order_id IS NULL
                 OR LTRIM(RTRIM(order_id)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_order_id_count,

    SUM(
        CASE
            WHEN review_score IS NULL
                 OR review_score NOT BETWEEN 1 AND 5
            THEN 1
            ELSE 0
        END
    ) AS invalid_review_score_count,

    SUM(
        CASE
            WHEN review_comment_title IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_review_title_count,

    SUM(
        CASE
            WHEN review_comment_message IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_review_message_count,

    SUM(
        CASE
            WHEN review_creation_date IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_creation_date_count,

    SUM(
        CASE
            WHEN review_answer_timestamp IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_answer_timestamp_count
FROM core.order_reviews;
GO

SELECT
    review_id,
    order_id,
    COUNT(*) AS duplicate_count
FROM core.order_reviews
GROUP BY
    review_id,
    order_id
HAVING COUNT(*) > 1;
GO

SELECT
    review_score,
    COUNT(*) AS review_count
FROM core.order_reviews
GROUP BY review_score
ORDER BY review_score;
GO

SELECT
    SUM(
        CASE
            WHEN review_answer_timestamp < review_creation_date
            THEN 1
            ELSE 0
        END
    ) AS answer_before_creation_count
FROM core.order_reviews;
GO

SELECT
    SUM(
        CASE
            WHEN o.order_id IS NULL
            THEN 1
            ELSE 0
        END
    ) AS orphan_order_count
FROM core.order_reviews r
LEFT JOIN core.orders o
    ON r.order_id = o.order_id;
GO

SELECT TOP (20)
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM core.order_reviews
WHERE review_answer_timestamp < review_creation_date
ORDER BY review_creation_date;
GO