-- Calculate total, travel, and hotel expenses for branches B100007, B100008, and B100009 from 2012 to 2021
SELECT
    e.BranchId,
    EXTRACT(YEAR FROM bt.StartDate) AS Year,
    SUM(bt.TravelCosts) AS TotalTravelCosts,
    SUM(bt.HotelCosts) AS TotalHotelCosts,
    SUM(bt.TravelCosts + bt.HotelCosts) AS TotalTripExpenses
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2` AS bt
JOIN
    `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
ON
    bt.EmployeeId = e.EmployeeId
WHERE
    e.BranchId IN ('B100007', 'B100008', 'B100009')
    AND EXTRACT(YEAR FROM bt.StartDate) BETWEEN 2012 AND 2021
GROUP BY
    e.BranchId, Year
ORDER BY
    e.BranchId, Year;
