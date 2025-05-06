-- Calculate average running costs for specific branches
WITH running_costs AS (
    SELECT
        BranchId,
        SUM(CAST(Costs AS FLOAT64)) AS SUMRunningCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
    WHERE
        BranchId IN ('B100007', 'B100008', 'B100009')
    GROUP BY
        BranchId
),

-- Calculate average employees's salary for specific branches
salary_costs AS (
    SELECT
        BranchId,
        SUM(Salary) AS SUMSalaryCosts
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2`
    WHERE
        BranchId IN ('B100007', 'B100008', 'B100009')
    GROUP BY
        BranchId
),

-- Calculate average equipment order costs for specific branches using EmployeeId to link to BranchId
equipment_order_costs AS (
    SELECT
        e.BranchId,
        SUM(Costs) AS SUMEquipmentOrderCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrEquipmentOrderItems_2` AS eoi
    JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
    ON
        eoi.EmployeeId = e.EmployeeId
    WHERE
        e.BranchId IN ('B100007', 'B100008', 'B100009')
    GROUP BY
        e.BranchId
)

-- Combine all average costs for each specific branch
SELECT
    b.BranchId,
    COALESCE(rc.SUMRunningCost, 0) AS SUMRunningCost,
    COALESCE(eoc.SUMEquipmentOrderCost, 0) AS SUMEquipmentOrderCost,
    COALESCE(sc.SUMSalaryCosts, 0) AS SUMSalaryCosts,
    (COALESCE(rc.SUMRunningCost, 0) + COALESCE(eoc.SUMEquipmentOrderCost, 0) + COALESCE(sc.SUMSalaryCosts, 0)) AS TotalSUMCost
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranches_2` AS b
LEFT JOIN
    running_costs AS rc ON b.BranchId = rc.BranchId
LEFT JOIN
    equipment_order_costs AS eoc ON b.BranchId = eoc.BranchId
LEFT JOIN
    salary_costs AS sc ON b.BranchId = sc.BranchId
WHERE
    b.BranchId IN ('B100007', 'B100008', 'B100009')
ORDER BY
    b.BranchId;


/*
-- Calculate average running costs for specific branches
WITH running_costs AS (
    SELECT
        BranchId,
        AVG(CAST(Costs AS FLOAT64)) AS AvgRunningCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
    WHERE
        BranchId IN ('B100007', 'B100008', 'B100009')
    GROUP BY
        BranchId
),

-- Calculate average business trip costs for specific branches
business_trip_costs AS (
    SELECT
        e.BranchId,
        AVG(CAST(bt.TravelCosts AS FLOAT64)) AS AvgTravelCosts
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2` AS bt
    JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
    ON
        bt.EmployeeId = e.EmployeeId
    WHERE
        e.BranchId IN ('B100007', 'B100008', 'B100009')
    GROUP BY
        e.BranchId
),

-- Calculate average employees's salary for specific branches
salary_costs AS (
    SELECT
        BranchId,
        AVG(Salary) AS AvgSalaryCosts
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2`
    WHERE
        BranchId IN ('B100007', 'B100008', 'B100009')
    GROUP BY
        BranchId
),

-- Calculate average equipment order costs for specific branches using EmployeeId to link to BranchId
equipment_order_costs AS (
    SELECT
        e.BranchId,
        AVG(Costs) AS AvgEquipmentOrderCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrEquipmentOrderItems_2` AS eoi
    JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
    ON
        eoi.EmployeeId = e.EmployeeId
    WHERE
        e.BranchId IN ('B100007', 'B100008', 'B100009')
    GROUP BY
        e.BranchId
)

-- Combine all average costs for each specific branch
SELECT
    b.BranchId,
    COALESCE(rc.AvgRunningCost, 0) AS AvgRunningCost,
    COALESCE(btc.AvgTravelCosts, 0) AS AvgTravelCosts,
    COALESCE(eoc.AvgEquipmentOrderCost, 0) AS AvgEquipmentOrderCost,
    COALESCE(sc.AvgSalaryCosts, 0) AS AvgSalaryCosts,
    (COALESCE(rc.AvgRunningCost, 0) + COALESCE(btc.AvgTravelCosts, 0) + COALESCE(eoc.AvgEquipmentOrderCost, 0) + COALESCE(sc.AvgSalaryCosts, 0)) AS TotalAvgCost
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
WHERE
    b.BranchId IN ('B100007', 'B100008', 'B100009')
ORDER BY
    b.BranchId;
*/
