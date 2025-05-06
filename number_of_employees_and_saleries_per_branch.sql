-- count the number of employees and saleries per branch
SELECT
    BranchId,
    COUNT(EmployeeId) AS TotalEmployees,
    SUM(Salary) AS TotalSalaries
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2`
GROUP BY
    BranchId
ORDER BY
    BranchId;
