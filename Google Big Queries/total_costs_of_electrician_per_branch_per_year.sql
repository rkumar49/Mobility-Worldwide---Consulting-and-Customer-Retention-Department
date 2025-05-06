SELECT
    BranchId,
    AVG(CAST(Costs AS FLOAT64)) AS AvgRunningCostsElectrician,
    EXTRACT(YEAR FROM DATE) AS Year
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
WHERE
    ProcessType = "Electrician"
GROUP BY
    BranchId,Year;