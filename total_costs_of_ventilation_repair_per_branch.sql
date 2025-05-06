SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningVentilationRepair
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Ventilation repair"
GROUP BY
    BranchId;