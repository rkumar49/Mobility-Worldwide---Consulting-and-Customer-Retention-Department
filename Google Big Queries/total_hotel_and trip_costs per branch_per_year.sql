SELECT
    e.BranchId,
    EXTRACT(YEAR FROM bt.StartDate) AS Year,
    SUM(CAST(bt.TravelCosts AS FLOAT64)) AS TotalTravelCosts,
    SUM(CAST(bt.HotelCosts AS FLOAT64)) AS TotalHotelCosts,
    SUM(bt.TravelCosts + bt.HotelCosts) AS TotalTripExpenses
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2` AS bt
JOIN
    `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
ON
    bt.EmployeeId = e.EmployeeId
GROUP BY
    e.BranchId, Year
ORDER BY
    e.BranchId, Year;
