USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.products', 'U') IS NULL
BEGIN
    CREATE TABLE staging.products
    (
        product_id                   VARCHAR(50),
        product_category_name        VARCHAR(100),
        product_name_length          INT,
        product_description_length   INT,
        product_photos_qty           INT,
        product_weight_g             DECIMAL(10, 2),
        product_length_cm            DECIMAL(10, 2),
        product_height_cm            DECIMAL(10, 2),
        product_width_cm             DECIMAL(10, 2)
    );
END;
GO