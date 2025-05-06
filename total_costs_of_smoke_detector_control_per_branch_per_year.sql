SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningSmokeDetectorControl,
    EXTRACT(YEAR FROM DATE) AS Year
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Smoke detector control"
GROUP BY
    BranchId, Year;