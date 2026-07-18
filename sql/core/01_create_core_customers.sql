USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.customers', 'U') IS NULL
BEGIN
    CREATE TABLE core.customers
    (
        customer_id VARCHAR(32) NOT NULL,
        customer_unique_id VARCHAR(32) NOT NULL,
        customer_zip_code_prefix INT NOT NULL,
        customer_city VARCHAR(100) NOT NULL,
        customer_state CHAR(2) NOT NULL,

        CONSTRAINT PK_core_customers
            PRIMARY KEY (customer_id)
    );
END;
GO