-- Train the regression model to predict branch expenses
CREATE OR REPLACE MODEL branches.branch_expense_model
OPTIONS(model_type='linear_reg', input_label_cols=['TotalBranchExpenses']) AS
SELECT 
    TotalRunningCost,
    TotalSalaries,
    TotalEquipmentOrderCost,
    TotalBranchExpenses  -- Assuming this is your label column
FROM 
    branches.branch_profitability_training;
