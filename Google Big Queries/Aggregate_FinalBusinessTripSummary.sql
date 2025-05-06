SELECT 
    OriginCity,
    DestinationCity,
    AVG(TravelTimeMinutes) AS AverageTravelTimeMinutes,
    AVG(DistanceKm) AS AverageDistanceKm,
    SUM(HotelCosts) AS TotalHotelCosts,
    SUM(TravelCosts) AS TotalTravelCosts,
    COUNT(TripId) AS TotalTrips
FROM 
    my-project-scenario2-vlba2.branches.FinalBusinessTripsSummary
GROUP BY 
    OriginCity, DestinationCity
ORDER by TotalTrips DESC;



