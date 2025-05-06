-- Create a dataset for clustering potential new branch locations
CREATE OR REPLACE TABLE my-project-scenario2-vlba2.branches.client_locations AS
SELECT 
    CAST(SPLIT(REGEXP_REPLACE(DestinationCoordinates, r'[()]', ''), ',')[OFFSET(0)] AS FLOAT64) AS Latitude,
    CAST(SPLIT(REGEXP_REPLACE(DestinationCoordinates, r'[()]', ''), ',')[OFFSET(1)] AS FLOAT64) AS Longitude
FROM 
    my-project-scenario2-vlba2.branches.FinalBusinessTripsSummary