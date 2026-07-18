USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.product_category_translation;
GO

INSERT INTO core.product_category_translation
(
    product_category_name,
    product_category_name_english
)
SELECT
    LOWER(LTRIM(RTRIM(product_category_name))),
    LOWER(LTRIM(RTRIM(product_category_name_english)))
FROM staging.product_category_translation;
GO

SELECT
    COUNT(*) AS core_category_translation_row_count
FROM core.product_category_translation;
GO