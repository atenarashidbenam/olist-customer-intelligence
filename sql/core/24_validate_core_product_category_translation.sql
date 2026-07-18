USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_category_name) AS distinct_category_names,
    COUNT(DISTINCT product_category_name_english) AS distinct_english_names
FROM core.product_category_translation;
GO

SELECT
    SUM(
        CASE
            WHEN product_category_name IS NULL
                 OR LTRIM(RTRIM(product_category_name)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_category_name_count,

    SUM(
        CASE
            WHEN product_category_name_english IS NULL
                 OR LTRIM(RTRIM(product_category_name_english)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_english_name_count
FROM core.product_category_translation;
GO

SELECT
    product_category_name,
    COUNT(*) AS duplicate_count
FROM core.product_category_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1;
GO

SELECT
    product_category_name_english,
    COUNT(*) AS duplicate_count
FROM core.product_category_translation
GROUP BY product_category_name_english
HAVING COUNT(*) > 1;
GO

SELECT
    p.product_category_name,
    COUNT(*) AS product_count
FROM core.products AS p
LEFT JOIN core.product_category_translation AS t
    ON p.product_category_name = t.product_category_name
WHERE
    p.product_category_name IS NOT NULL
    AND t.product_category_name IS NULL
GROUP BY
    p.product_category_name
ORDER BY
    product_count DESC;
GO

SELECT
    COUNT(*) AS products_without_translation_count
FROM core.products AS p
LEFT JOIN core.product_category_translation AS t
    ON p.product_category_name = t.product_category_name
WHERE
    p.product_category_name IS NOT NULL
    AND t.product_category_name IS NULL;
GO