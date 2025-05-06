SELECT BranchId, AVG(TotalCost) AS AverageCost, Year
 FROM my-project-scenario2-vlba2.branches.ToTALCOSTSOFABRANCHPERYEAR 
GROUP BY BranchId, Year