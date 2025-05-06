-- Calculate average running costs
WITH running_costs AS (
    SELECT
        BranchId,
        SUM(CAST(Costs AS FLOAT64)) AS SUMRunningCost
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
    GROUP BY
        BranchId
),


-- Calculate average employees's salary
salary_costs AS (
    SELECT
        BranchId,
        SUM(Salary) AS SUMSalaryCosts
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2`
    GROUP BY
        BranchId
),

-- Calculate average equipment order costs using EmployeeId to link to BranchId
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
    GROUP BY
        e.BranchId
)

-- Combine all average costs for each branch
SELECT
    b.BranchId,
    COALESCE(rc.SUMRunningCost, 0) AS SUMRunningCost,
    COALESCE(eoc.SUMEquipmentOrderCost, 0) AS SUMEquipmentOrderCost,
    COALESCE(sc.SUMSalaryCosts, 0) AS SUMSalaryCosts,
    (COALESCE(rc.SUMRunningCost, 0) + COALESCE(eoc.SUMEquipmentOrderCost, 0) + COALESCE(sc.SUMSalaryCosts, 0)) AS TotalCost
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranches_2` AS b
LEFT JOIN
    running_costs AS rc ON b.BranchId = rc.BranchId
LEFT JOIN
    equipment_order_costs AS eoc ON b.BranchId = eoc.BranchId
LEFT JOIN
    salary_costs AS sc ON b.BranchId = sc.BranchId    
ORDER BY
    b.BranchId;
