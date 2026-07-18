USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.sellers;
GO

BULK INSERT staging.sellers
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\raw\archive\olist_sellers_dataset.csv'
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

SELECT COUNT(*) AS seller_row_count
FROM staging.sellers;
GO