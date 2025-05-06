SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningVehicleRepair,
    EXTRACT(YEAR FROM DATE) AS Year
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Vehicle repair"
GROUP BY
    BranchId, Year;