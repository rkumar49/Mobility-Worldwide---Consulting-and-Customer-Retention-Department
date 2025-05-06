--Clustering client locations
SELECT 
    Latitude,
    Longitude,
    CENTROID_ID AS cluster
FROM 
    ML.PREDICT(MODEL branches.branch_location_clustering,
    (
        SELECT 
            Latitude,
            Longitude
        FROM 
            branches.client_locations
    ));
----------------------------------------------------------------------

-- Extract centroids with latitude and longitude separated
WITH Centroids AS (
    SELECT 
        centroid_id,
        CASE 
            WHEN feature = 'Latitude' THEN numerical_value 
        END AS Latitude,
        CASE 
            WHEN feature = 'Longitude' THEN numerical_value 
        END AS Longitude
    FROM 
        ML.CENTROIDS(MODEL branches.branch_location_clustering)
)
-- Aggregate to group by centroid_id and get latitude and longitude for each centroid
SELECT 
    centroid_id AS cluster,
    MAX(Latitude) AS CentroidLatitude,
    MAX(Longitude) AS CentroidLongitude
FROM 
    Centroids
GROUP BY 
    centroid_id;
----------------------------------------------------------------------

--Count of Locations
SELECT 
    CENTROID_ID AS cluster, count(*) AS TotalLocations
FROM 
    ML.PREDICT(MODEL branches.branch_location_clustering,
    (
        SELECT 
            Latitude,
            Longitude
        FROM 
            branches.client_locations
    ))
GROUP BY cluster;





