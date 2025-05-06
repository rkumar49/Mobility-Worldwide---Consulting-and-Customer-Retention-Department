SELECT BranchId, AVG(TotalCost) AS AverageCost
 FROM my-project-scenario2-vlba2.branches.ToTALCOSTSOFABRANCHPERYEAR
GROUP BY BranchId