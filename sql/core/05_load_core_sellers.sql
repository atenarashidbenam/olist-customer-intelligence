USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.sellers;
GO

INSERT INTO core.sellers
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT
    LTRIM(RTRIM(seller_id)),
    seller_zip_code_prefix,
    LOWER(LTRIM(RTRIM(seller_city))),
    UPPER(LTRIM(RTRIM(seller_state)))
FROM staging.sellers;
GO

SELECT
    COUNT(*) AS core_seller_row_count
FROM core.sellers;
GO