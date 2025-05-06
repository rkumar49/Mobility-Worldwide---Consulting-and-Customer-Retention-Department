SELECT
    BranchId,
    AVG(CAST(Costs AS FLOAT64)) AS AvgRunningElectricityAdditionalPayment
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Electricity additional payment"
GROUP BY
    BranchId;