CREATE OR REPLACE FUNCTION `my-project-scenario2-vlba2.branches.geocode_address`(address STRING)
RETURNS GEOGRAPHY
REMOTE
WITH CONNECTION `projects/my-project-scenario2-vlba2/locations/europe-west3/connections/geocode_function_connection`
OPTIONS (
  endpoint = 'https://europe-west3-my-project-scenario2-vlba2.cloudfunctions.net/geocode'  
);
