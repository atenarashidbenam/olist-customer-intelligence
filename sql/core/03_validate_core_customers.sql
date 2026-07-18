USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_customer_ids,
    COUNT(DISTINCT customer_unique_id) AS distinct_unique_customers
FROM core.customers;
GO

SELECT
    SUM(CASE WHEN customer_id IS NULL OR LTRIM(RTRIM(customer_id)) = '' THEN 1 ELSE 0 END)
        AS invalid_customer_id_count,

    SUM(CASE WHEN customer_unique_id IS NULL OR LTRIM(RTRIM(customer_unique_id)) = '' THEN 1 ELSE 0 END)
        AS invalid_customer_unique_id_count,

    SUM(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 ELSE 0 END)
        AS missing_zip_code_count,

    SUM(CASE WHEN customer_city IS NULL OR LTRIM(RTRIM(customer_city)) = '' THEN 1 ELSE 0 END)
        AS invalid_city_count,

    SUM(CASE WHEN customer_state IS NULL OR LEN(LTRIM(RTRIM(customer_state))) <> 2 THEN 1 ELSE 0 END)
        AS invalid_state_count
FROM core.customers;
GO

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM core.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
GO

SELECT
    customer_state,
    COUNT(*) AS customer_count
FROM core.customers
GROUP BY customer_state
ORDER BY customer_state;
GO