-- Train the regression model to predict branch expenses
CREATE OR REPLACE MODEL branches.trip_expense_model
OPTIONS(model_type='linear_reg', input_label_cols=['TotalBusinessTripCost']) AS
SELECT 
    TotalTravelCost,
    TotalHotelCost,
    TotalBusinessTripCost  -- Assuming this is your label column
FROM 
    branches.branch_profitability_training_2
WHERE
    BranchId IN ('B100007','B100008','B100009')