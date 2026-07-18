USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.order_payments;
GO

BULK INSERT staging.order_payments
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\raw\archive\olist_order_payments_dataset.csv'
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

SELECT COUNT(*) AS order_payment_row_count
FROM staging.order_payments;
GO