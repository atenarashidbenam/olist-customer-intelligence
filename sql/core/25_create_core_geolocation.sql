USE OlistCustomerIntelligence;
GO

IF OBJECT_ID('core.geolocation', 'U') IS NULL
BEGIN
    CREATE TABLE core.geolocation
    (
        geolocation_zip_code_prefix INT NOT NULL,
        geolocation_lat DECIMAL(10, 7) NOT NULL,
        geolocation_lng DECIMAL(10, 7) NOT NULL,
        geolocation_city VARCHAR(100) NOT NULL,
        geolocation_state CHAR(2) NOT NULL
    );
END;
GO