USE OlistCustomerIntelligence;
GO

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT geolocation_zip_code_prefix) AS distinct_zip_codes
FROM core.geolocation;
GO

SELECT
    SUM(
        CASE
            WHEN geolocation_zip_code_prefix IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_zip_code_count,

    SUM(
        CASE
            WHEN geolocation_lat IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_latitude_count,

    SUM(
        CASE
            WHEN geolocation_lng IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_longitude_count,

    SUM(
        CASE
            WHEN geolocation_city IS NULL
                 OR LTRIM(RTRIM(geolocation_city)) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_city_count,

    SUM(
        CASE
            WHEN geolocation_state IS NULL
                 OR LTRIM(RTRIM(geolocation_state)) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_state_count
FROM core.geolocation;
GO

SELECT
    geolocation_zip_code_prefix,
    COUNT(*) AS duplicate_count
FROM core.geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
GO

SELECT
    MIN(geolocation_lat) AS minimum_latitude,
    MAX(geolocation_lat) AS maximum_latitude,
    MIN(geolocation_lng) AS minimum_longitude,
    MAX(geolocation_lng) AS maximum_longitude
FROM core.geolocation;
GO

SELECT
    geolocation_state,
    COUNT(*) AS location_count
FROM core.geolocation
GROUP BY geolocation_state
ORDER BY location_count DESC;
GO

SELECT TOP (20)
    *
FROM core.geolocation
ORDER BY geolocation_zip_code_prefix;
GO