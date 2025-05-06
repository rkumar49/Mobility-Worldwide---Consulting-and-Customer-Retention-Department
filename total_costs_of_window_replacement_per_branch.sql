SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningWindowReplacement
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Window replacement"
GROUP BY
    BranchId;