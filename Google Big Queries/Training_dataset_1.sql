CREATE OR REPLACE TABLE my-project-scenario2-vlba2.branches.branch_profitability_training AS
SELECT 
    b.BranchId,
    b.City,
    b.PostalCode,
    b.Latitude,
    b.Longitude,
    r.TotalRunningCost,
    e.TotalSalaries,
    t.TotalBusinessTripCost,
    t.TotalBusinessTrips,
    t.AverageHotelCost,
    t.AverageTravelCost,
    (r.TotalRunningCost + e.TotalSalaries) AS TotalBranchExpenses
FROM 
    my-project-scenario2-vlba2.branches.MwwCcrBranches_2 b
JOIN 
    (
        SELECT BranchId, SUM(Costs) AS TotalRunningCost
        FROM my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2
        GROUP BY BranchId
    ) r ON b.BranchId = r.BranchId
JOIN 
    (
        SELECT BranchId, SUM(Salary) AS TotalSalaries
        FROM my-project-scenario2-vlba2.branches.MwwCcrEmployees_2
        GROUP BY BranchId
    ) e ON b.BranchId = e.BranchId
LEFT JOIN 
    (
        SELECT 
            OriginBranchId AS BranchId,
            SUM(TravelCosts + HotelCosts) AS TotalBusinessTripCost,
            COUNT(TripId) AS TotalBusinessTrips,
            AVG(HotelCosts) AS AverageHotelCost,
            AVG(TravelCosts) AS AverageTravelCost
        FROM 
            my-project-scenario2-vlba2.branches.FinalBusinessTripsSummary
        GROUP BY 
            OriginBranchId
    ) t ON b.BranchId = t.BranchId;