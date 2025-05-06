CREATE OR REPLACE MODEL branches.avg_running_cost_model
OPTIONS(model_type='linear_reg', input_label_cols=['AvgRunningCost']) AS
SELECT BranchId, AVG(SUMRunningCost) as AvgRunningCost, Year
FROM branches.ToTALCOSTSOFABRANCHPERYEAR 
Where BranchId in ('B100007', 'B100008', 'B100009')
GROUP BY BranchId, Year