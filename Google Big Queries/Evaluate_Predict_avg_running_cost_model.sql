--Evaluate
SELECT
  *
FROM
  ML.EVALUATE(MODEL branches.avg_running_cost_model, (
    SELECT 
        BranchId, 
        AVG(SUMRunningCost) AS AvgRunningCost, 
        Year
    FROM 
        branches.ToTALCOSTSOFABRANCHPERYEAR 
    WHERE 
        BranchId IN ('B100007', 'B100008', 'B100009')
    GROUP BY 
        BranchId, 
        Year
));

--Predict
SELECT 
    BranchId, 
    Year,
    predicted_AvgRunningCost
FROM 
    ML.PREDICT(MODEL branches.avg_running_cost_model,
    (
        SELECT 
            'B100016' AS BranchId,
            2022 AS Year
    ));
