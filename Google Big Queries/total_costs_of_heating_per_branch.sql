SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningHeatingCosts
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Heating costs"
GROUP BY
    BranchId;