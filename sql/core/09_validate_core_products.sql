USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS distinct_product_ids
FROM core.products;
GO

SELECT
    SUM(
        CASE
            WHEN product_id IS NULL
                 OR LTRIM(RTRIM(product_id)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_product_id_count,

    SUM(
        CASE
            WHEN product_category_name IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_category_count,

    SUM(
        CASE
            WHEN product_name_length IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_name_length_count,

    SUM(
        CASE
            WHEN product_description_length IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_description_length_count,

    SUM(
        CASE
            WHEN product_photos_qty IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_photos_qty_count,

    SUM(
        CASE
            WHEN product_weight_g IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_weight_count,

    SUM(
        CASE
            WHEN product_length_cm IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_length_count,

    SUM(
        CASE
            WHEN product_height_cm IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_height_count,

    SUM(
        CASE
            WHEN product_width_cm IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_width_count
FROM core.products;
GO

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM core.products
GROUP BY product_id
HAVING COUNT(*) > 1;
GO

SELECT
    SUM(
        CASE
            WHEN product_weight_g <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_weight_count,

    SUM(
        CASE
            WHEN product_length_cm <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_length_count,

    SUM(
        CASE
            WHEN product_height_cm <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_height_count,

    SUM(
        CASE
            WHEN product_width_cm <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_width_count,

    SUM(
        CASE
            WHEN product_photos_qty < 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_photos_qty_count
FROM core.products;
GO

SELECT
    product_category_name,
    COUNT(*) AS product_count
FROM core.products
GROUP BY product_category_name
ORDER BY product_count DESC;
GO