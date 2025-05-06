-- Evaluate the regression model
SELECT 
    * 
FROM 
    ML.EVALUATE(MODEL branches.trip_expense_model);

SELECT 
    *
FROM 
    ML.PREDICT(MODEL branches.trip_expense_model,
    (
        SELECT 
              15860 AS TotalTravelCost,
              478956 AS TotalHotelCost,
            
    ));