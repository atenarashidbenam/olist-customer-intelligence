USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.products', 'U') IS NULL
BEGIN
    CREATE TABLE core.products
    (
        product_id VARCHAR(32) NOT NULL,
        product_category_name VARCHAR(100) NULL,
        product_name_length INT NULL,
        product_description_length INT NULL,
        product_photos_qty INT NULL,
        product_weight_g INT NULL,
        product_length_cm INT NULL,
        product_height_cm INT NULL,
        product_width_cm INT NULL,

        CONSTRAINT PK_core_products
            PRIMARY KEY (product_id)
    );
END;
GO