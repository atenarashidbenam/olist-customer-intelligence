USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.customers;
GO

INSERT INTO core.customers
(
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT
    LTRIM(RTRIM(customer_id)),
    LTRIM(RTRIM(customer_unique_id)),
    customer_zip_code_prefix,
    LOWER(LTRIM(RTRIM(customer_city))),
    UPPER(LTRIM(RTRIM(customer_state)))
FROM staging.customers;
GO

SELECT COUNT(*) AS core_customer_row_count
FROM core.customers;
GO