SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningPlumbingService
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Plumbing service"
GROUP BY
    BranchId;