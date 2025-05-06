-- Query to extract origin and destination for each business trip with hotel staying
SELECT
    bt.BusinessTripId,
    e.EmployeeId,
    e.BranchId AS OriginBranchId,
    b.City AS OriginCity,
    bt.City AS DestinationCity,
    bt.PostalCode AS DestinationPostalCode,
    bt.HotelCosts,
    bt.TravelCosts
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2` AS bt
JOIN
    `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
ON
    bt.EmployeeId = e.EmployeeId
JOIN
    `my-project-scenario2-vlba2.branches.MwwCcrBranches_2` AS b
ON
    e.BranchId = b.BranchId
WHERE
    bt.HotelCosts > 0.0 AND bt.TravelCosts > 0.0    
ORDER BY
    e.BranchId;