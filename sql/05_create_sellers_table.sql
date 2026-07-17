USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.sellers', 'U') IS NULL
BEGIN
    CREATE TABLE staging.sellers
    (
        seller_id               VARCHAR(50),
        seller_zip_code_prefix  INT,
        seller_city             VARCHAR(100),
        seller_state            CHAR(2)
    );
END;
GO