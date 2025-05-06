WITH running_costs AS (
    SELECT
        BranchId,
        SUM(CAST(Costs AS FLOAT64)) AS SumRunningCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
    GROUP BY
        BranchId
),
business_trip_costs AS (
    SELECT
        e.BranchId,
        SUM(CAST(bt.TravelCosts AS FLOAT64)) AS SumTravelCosts,
        SUM(CAST(bt.HotelCosts AS FLOAT64)) AS SumHotelCosts
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2` AS bt
    JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
    ON
        bt.EmployeeId = e.EmployeeId
    GROUP BY
        e.BranchId
),
salary_costs AS (
    SELECT
        BranchId,
        TotalSalary
    FROM
        `my-project-scenario2-vlba2.branches.total_employee_and_salaries_per_branch`
),
equipment_order_costs AS (
    SELECT
        e.BranchId,
        SUM(Costs) AS SumEquipmentOrderCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrEquipmentOrderItems_2` AS eoi
    JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
    ON
        eoi.EmployeeId = e.EmployeeId
    GROUP BY
        e.BranchId
)
SELECT
    b.BranchId,
    COALESCE(rc.SumRunningCost, 0) AS SumRunningCost,
    COALESCE(btc.SumTravelCosts, 0) AS SumTravelCosts,
    COALESCE(btc.SumHotelCosts, 0) AS SumHotelCosts,
    COALESCE(eoc.SumEquipmentOrderCost, 0) AS SumEquipmentOrderCost,
    TotalSalary,
    (COALESCE(rc.SumRunningCost, 0) + COALESCE(btc.SumTravelCosts, 0) + COALESCE(btc.SumHotelCosts, 0) + COALESCE(eoc.SumEquipmentOrderCost, 0) + TotalSalary) AS TotalCostWithTrips,
    (COALESCE(rc.SumRunningCost, 0) + COALESCE(eoc.SumEquipmentOrderCost, 0) + TotalSalary) AS TotalCostWithoutTrips
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranches_2` AS b
LEFT JOIN
    running_costs AS rc ON b.BranchId = rc.BranchId
LEFT JOIN
    business_trip_costs AS btc ON b.BranchId = btc.BranchId
LEFT JOIN
    equipment_order_costs AS eoc ON b.BranchId = eoc.BranchId
LEFT JOIN
    salary_costs AS sc ON b.BranchId = sc.BranchId
ORDER BY
    b.BranchId;