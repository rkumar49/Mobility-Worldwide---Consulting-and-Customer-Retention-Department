SELECT 
    City, 
    COUNT(*) AS Number_of_trips 
FROM 
    `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2`
WHERE 
    HotelCosts > 0
GROUP BY 
    City
ORDER BY 
    Number_of_trips DESC;
