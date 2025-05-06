SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningCostsWaterBill,
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Water bill"
GROUP BY
    BranchId;