SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SUMRunningTechnicalSupport
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Technical support"
GROUP BY
    BranchId;