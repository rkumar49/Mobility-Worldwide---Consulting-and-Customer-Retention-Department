SELECT
    BranchId,
    SUM(CAST(Costs AS FLOAT64)) AS SumRunningElectricityReimbursement
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Electricity reimbursement"
GROUP BY
    BranchId;