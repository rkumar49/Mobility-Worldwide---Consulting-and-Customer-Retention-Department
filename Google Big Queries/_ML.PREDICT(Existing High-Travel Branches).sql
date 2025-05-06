SELECT *
FROM
 ML.PREDICT(MODEL `my-project-scenario2-vlba2.branches.branch_cost_model`, (
  SELECT   
    3300 AS AvgRunningCost,
   70 AS AvgTravelCosts,
   95 AS AvgHotelCosts,
   6.75 AS AvgEquipmentOrderCost,
   108000 AS AvgSalaryCosts, -- Adjusted for potential higher salary
 )); 
