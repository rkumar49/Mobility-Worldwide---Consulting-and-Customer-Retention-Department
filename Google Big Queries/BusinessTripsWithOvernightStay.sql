SELECT
  O.EmployeeId,
  O.TripId,
  O.BranchId,
  b.Latitude AS OriginLatitude,
  b.Longitude AS OriginLongitude,
  b.City AS OriginCity,
  b.PostalCode AS OriginPOstalCode,
  O.DestinationCity,
  O.DestinationPostalCode
FROM
  (SELECT bt.EmployeeId,
          bt.BusinessTripId AS TripId,
          e.BranchId,
          bt.City AS DestinationCity,
          bt.PostalCode AS DestinationPostalCode,
          bt.HotelCosts
  FROM `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2` bt
  JOIN my-project-scenario2-vlba2.branches.MwwCcrEmployees_2 e ON bt.EmployeeId = e.EmployeeId ) as O
JOIN `my-project-scenario2-vlba2.branches.MwwCcrBranches_2` b ON O.BranchId = b.BranchId
where  O.HotelCosts >0
