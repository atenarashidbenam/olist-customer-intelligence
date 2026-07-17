USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.order_reviews', 'U') IS NULL
BEGIN
    CREATE TABLE staging.order_reviews
    (
        review_id                 VARCHAR(50),
        order_id                  VARCHAR(50),
        review_score              INT,
        review_comment_title      VARCHAR(255),
        review_comment_message    VARCHAR(MAX),
        review_creation_date      DATETIME2,
        review_answer_timestamp   DATETIME2
    );
END;
GO