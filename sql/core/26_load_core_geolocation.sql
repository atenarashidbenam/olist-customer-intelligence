USE OlistCustomerIntelligence;
GO

TRUNCATE TABLE core.geolocation;
GO

INSERT INTO core.geolocation
(
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
)
SELECT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    LOWER(LTRIM(RTRIM(geolocation_city))),
    UPPER(LTRIM(RTRIM(geolocation_state)))
FROM staging.geolocation;
GO

SELECT
    COUNT(*) AS core_geolocation_row_count
FROM core.geolocation;
GO