USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.product_category_translation;
GO

BULK INSERT staging.product_category_translation
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\raw\archive\product_category_name_translation.csv'
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

SELECT COUNT(*) AS category_translation_row_count
FROM staging.product_category_translation;
GO