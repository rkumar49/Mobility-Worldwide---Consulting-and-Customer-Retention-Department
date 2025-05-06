-- Train the clustering model
CREATE OR REPLACE MODEL branches.branch_location_clustering
OPTIONS(model_type='kmeans', num_clusters=5) AS
SELECT 
    Latitude,
    Longitude
FROM 
    branches.client_locations;