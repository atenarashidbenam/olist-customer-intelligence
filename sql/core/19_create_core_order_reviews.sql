USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.order_reviews', 'U') IS NULL
BEGIN
    CREATE TABLE core.order_reviews
    (
        review_id VARCHAR(32) NOT NULL,
        order_id VARCHAR(32) NOT NULL,
        review_score INT NOT NULL,
        review_comment_title VARCHAR(255) NULL,
        review_comment_message VARCHAR(MAX) NULL,
        review_creation_date DATETIME2 NOT NULL,
        review_answer_timestamp DATETIME2 NOT NULL,

        CONSTRAINT PK_core_order_reviews
            PRIMARY KEY (review_id, order_id),

        CONSTRAINT FK_core_order_reviews_orders
            FOREIGN KEY (order_id)
            REFERENCES core.orders(order_id)
    );
END;
GO