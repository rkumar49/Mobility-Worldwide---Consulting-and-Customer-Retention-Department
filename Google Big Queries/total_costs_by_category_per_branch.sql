-- categorize and sum costs by category per branch
SELECT
    BranchId,
    CASE
        WHEN ProcessType IN ('Office rent') THEN 'Operational Costs'
        WHEN ProcessType IN ('Electrician', 'Minor repairs', 'Vehicle repair', 'Heating engineer', 'Plumbing service', 'Construction work', 'Technical support', 'Ventilation repair', 'Window replacement', 'Smoke detector control') THEN 'Maintenance Costs'
        WHEN ProcessType IN ('Water bill', 'Heating costs', 'Electricity prepayment', 'Electricity reimbursement', 'Electricity additional payment') THEN 'Utility Costs'
        ELSE 'Other'
    END AS CostCategory,
    SUM(CAST(Costs AS FLOAT64)) AS TotalCosts
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBranchRunningCosts_2`
GROUP BY
    BranchId, CostCategory
ORDER BY
    BranchId, CostCategory;
