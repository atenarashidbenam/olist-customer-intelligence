USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.order_reviews;
GO

BULK INSERT staging.order_reviews
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\interim\olist_order_reviews_cleaned.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);
GO

SELECT COUNT(*) AS order_review_row_count
FROM staging.order_reviews;
GO