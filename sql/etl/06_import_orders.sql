USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.orders;
GO

BULK INSERT staging.orders
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\raw\archive\olist_orders_dataset.csv'
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

SELECT COUNT(*) AS order_row_count
FROM staging.orders;
GO