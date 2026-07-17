USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('staging.geolocation', 'U') IS NULL
BEGIN
    CREATE TABLE staging.geolocation
    (
        geolocation_zip_code_prefix  INT,
        geolocation_lat              DECIMAL(10, 7),
        geolocation_lng              DECIMAL(10, 7),
        geolocation_city             VARCHAR(100),
        geolocation_state            CHAR(2)
    );
END;
GO