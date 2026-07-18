USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.products;
GO

INSERT INTO core.products
(
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    LTRIM(RTRIM(product_id)),
    NULLIF(LOWER(LTRIM(RTRIM(product_category_name))), ''),
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM staging.products;
GO

SELECT
    COUNT(*) AS core_product_row_count
FROM core.products;
GO