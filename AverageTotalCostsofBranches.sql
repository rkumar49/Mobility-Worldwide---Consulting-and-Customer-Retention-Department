SELECT BranchId, 'AvgRunningCosts'  as CostType, AVG(SUMRunningCost) as Cost, Year
FROM my-project-scenario2-vlba2.branches.ToTALCOSTSOFABRANCHPERYEAR 
GROUP BY BranchId, Year
union all
select BranchId, 'AvgTravelCosts' as CostType, AVG(SUMTravelCosts) as Cost, Year
FROM my-project-scenario2-vlba2.branches.ToTALCOSTSOFABRANCHPERYEAR 
GROUP BY BranchId, Year
union all
select BranchId, 'AvgHotelCosts' as CostType, AVG(SUMHotelCosts) as Cost, Year
FROM my-project-scenario2-vlba2.branches.ToTALCOSTSOFABRANCHPERYEAR 
GROUP BY BranchId, Year
union all
select BranchId, 'AvgEquipmentOrderCosts' as CostType, AVG(SUMEquipmentOrderCost) as Cost, Year
FROM my-project-scenario2-vlba2.branches.ToTALCOSTSOFABRANCHPERYEAR 
GROUP BY BranchId, Year
union all
select BranchId, 'AvgSalaryCosts' as CostType, AVG(SUMSalaryCosts) as Cost, Year
FROM my-project-scenario2-vlba2.branches.ToTALCOSTSOFABRANCHPERYEAR 
GROUP BY BranchId, Year
Order by BranchId, Year