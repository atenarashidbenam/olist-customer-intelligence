USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.customers', 'U') IS NULL
BEGIN
    CREATE TABLE staging.customers
    (
        customer_id               VARCHAR(50),
        customer_unique_id        VARCHAR(50),
        customer_zip_code_prefix  INT,
        customer_city             VARCHAR(100),
        customer_state            CHAR(2)
    );
END;
GO