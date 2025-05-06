SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningHeatingEngineer
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Heating engineer"
GROUP BY
    BranchId;