-- Evaluate the regression model
SELECT 
    * 
FROM 
    ML.EVALUATE(MODEL branches.branch_expense_model);

SELECT 
    *
FROM 
    ML.PREDICT(MODEL branches.branch_expense_model,
    (
        SELECT 
            2900653 AS TotalRunningCost,
            1784138 AS TotalSalaries,
            18308 AS TotalEquipmentOrderCost
            
    ));