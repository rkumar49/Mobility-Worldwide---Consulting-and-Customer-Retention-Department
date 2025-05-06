SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningConstructionWork
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Construction work"
GROUP BY
    BranchId;