USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.order_items;
GO

BULK INSERT staging.order_items
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\raw\archive\olist_order_items_dataset.csv'
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

SELECT COUNT(*) AS order_item_row_count
FROM staging.order_items;
GO