USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE staging.geolocation;
GO

BULK INSERT staging.geolocation
FROM 'C:\Users\Atena\Desktop\project\olist-customer-intelligence\data\raw\archive\olist_geolocation_dataset.csv'
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

SELECT COUNT(*) AS geolocation_row_count
FROM staging.geolocation;
GO