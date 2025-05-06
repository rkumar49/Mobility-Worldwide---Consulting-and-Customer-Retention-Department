-- Step 1: Select employees with non-zero hotel costs from mwwccrbusinesstrips_2
WITH SelectedEmployees AS (
    SELECT
        EmployeeId
    FROM
        `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2`
    WHERE
        HotelCosts > 0
),

-- Step 2: Join SelectedEmployees with mwwccremployees to get the BranchId
EmployeeBranch AS (
    SELECT
        se.EmployeeId,
        e.BranchId
    FROM
        SelectedEmployees se
    INNER JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` e ON se.EmployeeId = e.EmployeeId
),

-- Step 3: Use the BranchId to join with mwwccrbranches_2 to find the StrategicRegionId
EmployeeRegion AS (
    SELECT
        eb.EmployeeId,
        eb.BranchId,
        b.StrategicRegionId
    FROM
        EmployeeBranch eb
    INNER JOIN
        `my-project-scenario2-vlba2.branches.MwwCcrBranches_2` b ON eb.BranchId = b.BranchId
)

-- Final Step: Group by StrategicRegionId to identify the region(s) where these employees are located
SELECT
    StrategicRegionId,
    COUNT(DISTINCT EmployeeId) AS NumberOfEmployees
FROM
    EmployeeRegion
GROUP BY
    StrategicRegionId
ORDER BY
    NumberOfEmployees DESC;



