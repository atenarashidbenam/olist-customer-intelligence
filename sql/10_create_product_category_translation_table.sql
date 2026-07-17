USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.product_category_translation', 'U') IS NULL
BEGIN
    CREATE TABLE staging.product_category_translation
    (
        product_category_name          VARCHAR(100),
        product_category_name_english  VARCHAR(100)
    );
END;
GO