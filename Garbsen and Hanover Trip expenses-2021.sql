SELECT 
    SUM(HotelCosts) AS HotelCosts, 
    SUM(TravelCosts) AS TravelCosts, 
    City,
    SUM(HotelCosts) + SUM(TravelCosts) AS TotalCosts
--select *
FROM 
    my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2
WHERE 
    City IN ('Garbsen', 'Hannover') and extract(year from StartDate)= 2021
GROUP BY 
    City;