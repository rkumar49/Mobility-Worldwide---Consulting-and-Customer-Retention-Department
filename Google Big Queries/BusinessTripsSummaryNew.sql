CREATE OR REPLACE TABLE `my-project-scenario2-vlba2.branches.BusinessTripsSummaryNew` AS
SELECT
  O.TripId,
  O.EmployeeId,
  O.BranchId AS OriginBranchId,
  b.City AS OriginCity,
  STRUCT(b.Latitude, b.Longitude) AS OriginCityCoordinates,
  O.DestinationCity,
  O.DestinationPostalCode,
  O.HotelCosts,
  O.TravelCosts
FROM
  (
    SELECT
      bt.EmployeeId,
      bt.BusinessTripId AS TripId,
      e.BranchId,
      bt.City AS DestinationCity,
      bt.PostalCode AS DestinationPostalCode,
      bt.HotelCosts,
      bt.TravelCosts
    FROM
      `my-project-scenario2-vlba2.branches.MwwCcrBusinessTrips_2` bt
    LEFT JOIN
      `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` e ON bt.EmployeeId = e.EmployeeId
  ) AS O
LEFT JOIN
  `my-project-scenario2-vlba2.branches.MwwCcrBranches_2` b ON O.BranchId = b.BranchId
  where  O.HotelCosts>0 --O.TravelCosts>0--
