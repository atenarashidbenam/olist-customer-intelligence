USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT seller_id) AS distinct_seller_ids
FROM core.sellers;
GO

SELECT
    SUM(
        CASE
            WHEN seller_id IS NULL
                 OR LTRIM(RTRIM(seller_id)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_seller_id_count,

    SUM(
        CASE
            WHEN seller_zip_code_prefix IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_zip_code_count,

    SUM(
        CASE
            WHEN seller_city IS NULL
                 OR LTRIM(RTRIM(seller_city)) = ''
            THEN 1
            ELSE 0
        END
    ) AS invalid_city_count,

    SUM(
        CASE
            WHEN seller_state IS NULL
                 OR LEN(LTRIM(RTRIM(seller_state))) <> 2
            THEN 1
            ELSE 0
        END
    ) AS invalid_state_count
FROM core.sellers;
GO

SELECT
    seller_id,
    COUNT(*) AS duplicate_count
FROM core.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;
GO

SELECT
    seller_state,
    COUNT(*) AS seller_count
FROM core.sellers
GROUP BY seller_state
ORDER BY seller_state;
GO