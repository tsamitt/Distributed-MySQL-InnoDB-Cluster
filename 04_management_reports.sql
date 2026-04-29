/* SQL Reports */
-- Sasmit Tomar Report --
SELECT  
    c.Contract_ID, 
    c.Contract_Type, 
    c.Investment_Amount AS Agreed_Budget, 
    SUM(i.Total_Amount_Due) AS Total_Billed, 
    (c.Investment_Amount - SUM(i.Total_Amount_Due)) AS Remaining_Budget, 
    ROUND((SUM(i.Total_Amount_Due) / c.Investment_Amount) * 100, 2) AS Budget_Utilization_Pct 
FROM contracts c 
JOIN invoice i ON c.Contract_ID = i.Contract_ID 
GROUP BY c.Contract_ID 
ORDER BY Budget_Utilization_Pct DESC; 

-- Sasmit Tomar Report --
SELECT  
    l.Location_ID, 
    jr.Job_Role_ID, 
    rc.Hourly_Rate, 
    rc.Currency_Code, 
    COUNT(DISTINCT i.Invoice_ID) AS Invoices_Processed, 
    SUM(il.Line_Total) AS Total_Revenue_Local 
FROM ZeroIndex.rate_cards rc 
JOIN ZeroIndex.Location l ON rc.Location_ID = l.Location_ID 
JOIN ZeroIndex.Job_Role jr ON rc.Role_ID = jr.Job_Role_ID 
JOIN ZeroIndex.invoice_line il ON il.Unit_Price = rc.Hourly_Rate 
JOIN ZeroIndex.invoice i ON il.Invoice_ID = i.Invoice_ID 
GROUP BY  
    l.Location_ID, 
    jr.Job_Role_ID, 
    rc.Hourly_Rate, 
    rc.Currency_Code 
ORDER BY  
    l.Location_ID, 
    jr.Job_Role_ID, 
    rc.Hourly_Rate; 

-- Sasmit Tomar Report --
SELECT  
    c.Contract_ID, 
    t.Max_Labor_Hours AS Agreed_Cap, 
    SUM(il.Quantity_or_Hours) AS Total_Hours_Billed, 
    CASE  
        WHEN SUM(il.Quantity_or_Hours) > t.Max_Labor_Hours THEN 'VIOLATION: OVER CAP' 
        WHEN SUM(il.Quantity_or_Hours) = t.Max_Labor_Hours THEN 'AT LIMIT' 
        ELSE 'COMPLIANT' 
    END AS Compliance_Status 
FROM contracts c 
JOIN hourly_terms t ON c.Contract_ID = t.Contract_ID 
JOIN invoice i ON c.Contract_ID = i.Contract_ID 
JOIN invoice_line il ON i.Invoice_ID = il.Invoice_ID 
GROUP BY c.Contract_ID, t.Max_Labor_Hours; 

