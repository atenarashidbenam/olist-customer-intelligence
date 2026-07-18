USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.sellers', 'U') IS NULL
BEGIN
    CREATE TABLE core.sellers
    (
        seller_id VARCHAR(32) NOT NULL,
        seller_zip_code_prefix INT NOT NULL,
        seller_city VARCHAR(100) NOT NULL,
        seller_state CHAR(2) NOT NULL,

        CONSTRAINT PK_core_sellers
            PRIMARY KEY (seller_id)
    );
END;
GO