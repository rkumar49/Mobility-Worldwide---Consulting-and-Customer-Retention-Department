-- the average costs per branch per year

WITH running_costs AS (
    SELECT
        BranchId,
        EXTRACT(YEAR FROM DATE) AS Year,
        SUM(CAST(Costs AS FLOAT64)) AS SUMRunningCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
    GROUP BY
        BranchId, Year
),
business_trip_costs AS (
    SELECT
        e.BranchId,
        EXTRACT(YEAR FROM bt.StartDate) AS Year,
        SUM(CAST(bt.TravelCosts AS FLOAT64)) AS SUMTravelCosts,
        SUM(CAST(bt.HotelCosts AS FLOAT64)) AS SUMHotelCosts
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2` AS bt
    JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
    ON
        bt.EmployeeId = e.EmployeeId
    WHERE
        bt.HotelCosts > 0.0 OR bt.TravelCosts > 0.0
    GROUP BY
        e.BranchId, Year
),

equipment_order_costs AS (
    SELECT
        e.BranchId,
        EXTRACT(YEAR FROM eoi.Date) AS Year,
        SUM(Costs) AS SUMEquipmentOrderCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrEquipmentOrderItems_2` AS eoi
    JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
    ON
        eoi.EmployeeId = e.EmployeeId 
    GROUP BY
        e.BranchId, Year
),


salary_costs AS (
    SELECT
        BranchId,
        Year,
        SUM(Salary) AS SUMSalaryCosts
    FROM
        `my-project-scenario2-vlba2.branches.SaleryPerEmployee`
    GROUP BY
        BranchId, Year
)

SELECT
    b.BranchId,
    COALESCE(rc.Year, btc.Year, eoc.Year, sc.Year) AS Year,
    COALESCE(rc.SUMRunningCost, 0) AS SUMRunningCost,
    COALESCE(btc.SUMTravelCosts, 0) AS SUMTravelCosts,
    COALESCE(btc.SUMHotelCosts, 0) AS SUMHotelCosts,
    COALESCE(eoc.SUMEquipmentOrderCost, 0) AS SUMEquipmentOrderCost,
    COALESCE(sc.SUMSalaryCosts, 0) AS SUMSalaryCosts,
    (COALESCE(rc.SUMRunningCost, 0) + COALESCE(btc.SUMTravelCosts, 0) + COALESCE(btc.SUMHotelCosts, 0) + COALESCE(eoc.SUMEquipmentOrderCost, 0)+ COALESCE(sc.SUMSalaryCosts, 0)) AS TotalCost
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranches_2` AS b
LEFT JOIN
    running_costs AS rc ON b.BranchId = rc.BranchId
LEFT JOIN
    business_trip_costs AS btc ON b.BranchId = btc.BranchId AND rc.Year = btc.Year
LEFT JOIN
    equipment_order_costs AS eoc ON b.BranchId = eoc.BranchId AND rc.Year = eoc.Year
LEFT JOIN
    salary_costs AS sc ON b.BranchId = sc.BranchId AND COALESCE(rc.Year, btc.Year, eoc.Year) = sc.Year      
ORDER BY
    b.BranchId, Year;
