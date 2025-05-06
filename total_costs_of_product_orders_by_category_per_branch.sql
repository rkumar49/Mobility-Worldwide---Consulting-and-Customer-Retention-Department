-- categorize product orders and group by branch
SELECT
    e.BranchId,
    CASE
        WHEN o.ProductName IN ('Printer cartridge (black)', 'Printer cartridge (color)', 'Printer paper') THEN 'Printing Supplies'
        WHEN o.ProductName IN ('Pen', 'Paper clips (package)', 'Pencil', 'Notepad') THEN 'Office Supplies'
        ELSE 'Other'
    END AS ProductCategory,
    SUM(o.Quantity) AS TotalQuantity,
    SUM(CAST(Costs AS FLOAT64)) AS SumTotalCost
FROM
    `my-project-scenario2-vlba2.branches.MwwCcrEquipmentOrderItems_2` AS o
JOIN
    `my-project-scenario2-vlba2.branches.MwwCcrEmployees_2` AS e
ON
    o.EmployeeId = e.EmployeeId
GROUP BY
    e.BranchId, ProductCategory
ORDER BY
    e.BranchId, ProductCategory;

