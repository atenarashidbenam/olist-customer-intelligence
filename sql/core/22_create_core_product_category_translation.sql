USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.product_category_translation', 'U') IS NULL
BEGIN
    CREATE TABLE core.product_category_translation
    (
        product_category_name VARCHAR(100) NOT NULL,
        product_category_name_english VARCHAR(100) NOT NULL,

        CONSTRAINT PK_core_product_category_translation
            PRIMARY KEY (product_category_name)
    );
END;
GO