USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.products;
GO

BULK INSERT staging.products
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\raw\archive\olist_products_dataset.csv'
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

SELECT COUNT(*) AS product_row_count
FROM staging.products;
GO