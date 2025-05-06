-- Create a training dataset for branch profitability prediction
CREATE OR REPLACE TABLE my-project-scenario2-vlba2.branches.branch_profitability_training_2 AS
SELECT 
    b.BranchId,
    b.City,
    b.PostalCode,
    b.Latitude,
    b.Longitude,
    r.TotalRunningCost,
    e.TotalSalaries,
    eo.TotalEquipmentOrderCost,
    t.TotalBusinessTripCost,
    t.TotalBusinessTrips,
    t.TotalHotelCost,
    t.TotalTravelCost,
    (r.TotalRunningCost + e.TotalSalaries + eo.TotalEquipmentOrderCost) AS TotalBranchExpenses
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
            SUM(HotelCosts) AS TotalHotelCost,
            SUM(TravelCosts) AS TotalTravelCost
        FROM 
            my-project-scenario2-vlba2.branches.FinalBusinessTripsSummary
        GROUP BY 
            OriginBranchId
    ) t ON b.BranchId = t.BranchId
LEFT JOIN 
    (
        SELECT 
            emp.BranchId,
            SUM(e.Costs) AS TotalEquipmentOrderCost
        FROM 
            my-project-scenario2-vlba2.branches.MwwCcrEquipmentOrderItems_2 e
        JOIN 
            my-project-scenario2-vlba2.branches.MwwCcrEmployees_2 emp ON e.EmployeeId = emp.EmployeeId
        GROUP BY 
            emp.BranchId
    ) eo ON b.BranchId = eo.BranchId;
