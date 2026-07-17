USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.customers;
GO

BULK INSERT staging.customers
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\raw\archive\olist_customers_dataset.csv'
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

SELECT COUNT(*) AS customer_row_count
FROM staging.customers;
GO