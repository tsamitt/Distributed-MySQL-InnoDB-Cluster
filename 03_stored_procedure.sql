-- Sasmit Tomar Stored Procedure --
DELIMITER // 
CREATE PROCEDURE sp_CreateContractInvoice( 
    IN p_Contract_ID INT, 
    IN p_Pay_ID INT, 
    IN p_Invoice_Date DATE, 
    IN p_Hours_Worked DECIMAL(10,2), 
    IN p_Unit_Price DECIMAL(10,2), 
    IN p_Fixed_Term_ID INT, 
    IN p_Description VARCHAR(255) 
) 
BEGIN 
    DECLARE v_Entity_ID INT; 
    DECLARE v_Contract_Type VARCHAR(50); 
    DECLARE v_Start_Date DATE; 
    DECLARE v_End_Date DATE; 
    DECLARE v_Max_Hours INT; 
    DECLARE v_Used_Hours DECIMAL(10,2) DEFAULT 0; 
    DECLARE v_Line_Total DECIMAL(15,2); 
    DECLARE v_Invoice_ID INT; 
    DECLARE v_Line_ID INT; 
    DECLARE v_Fixed_Price DECIMAL(15,2); 
    DECLARE v_Fixed_Description VARCHAR(255); 
    SELECT Entity_ID, Contract_Type, Start_Date, End_Date 
    INTO v_Entity_ID, v_Contract_Type, v_Start_Date, v_End_Date 
    FROM contracts 
    WHERE Contract_ID = p_Contract_ID; 
    IF v_Entity_ID IS NULL THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid Contract_ID: contract not found'; 
    END IF; 
    IF p_Invoice_Date < v_Start_Date OR p_Invoice_Date > v_End_Date THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Contract is not active for the given invoice date'; 
    END IF; 
    SELECT COALESCE(MAX(Invoice_ID), 0) + 1 INTO v_Invoice_ID FROM invoice; 
    SELECT COALESCE(MAX(Line_ID), 0) + 1 INTO v_Line_ID FROM invoice_line; 
    IF UPPER(v_Contract_Type) = 'HOURLY' THEN 
        IF p_Hours_Worked IS NULL OR p_Hours_Worked <= 0 THEN 
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'For hourly contracts, Hours_Worked must be greater than 0'; 
        END IF; 
        IF p_Unit_Price IS NULL OR p_Unit_Price <= 0 THEN 
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'For hourly contracts, Unit_Price must be greater than 0'; 
        END IF; 
        SELECT MAX(Max_Labor_Hours) 
        INTO v_Max_Hours 
        FROM hourly_terms 
        WHERE Contract_ID = p_Contract_ID; 
        IF v_Max_Hours IS NULL THEN 
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'No hourly terms found for this hourly contract'; 
        END IF; 
        SELECT COALESCE(SUM(il.Quantity_or_Hours), 0) 
        INTO v_Used_Hours 
        FROM invoice i 
        JOIN invoice_line il ON i.Invoice_ID = il.Invoice_ID 
        WHERE i.Contract_ID = p_Contract_ID; 
        IF v_Used_Hours + p_Hours_Worked > v_Max_Hours THEN 
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Invoice would exceed Max_Labor_Hours for this contract'; 
        END IF; 
        SET v_Line_Total = p_Hours_Worked * p_Unit_Price; 
        INSERT INTO invoice ( 
            Invoice_ID, 
            Contract_ID, 
            Pay_ID, 
            Entity_ID, 
            Invoice_Date, 
            Total_Amount_Due, 
            Status 
        ) 
        VALUES ( 
            v_Invoice_ID, 
            p_Contract_ID, 
            p_Pay_ID, 
            v_Entity_ID, 
            p_Invoice_Date, 
            v_Line_Total, 
            'Invoiced' 
        ); 
        INSERT INTO invoice_line ( 
            Line_ID, 
            Invoice_ID, 
            Description, 
            Quantity_or_Hours, 
            Unit_Price, 
            Line_Total 
        ) 
        VALUES ( 
            v_Line_ID, 
            v_Invoice_ID, 
            p_Description, 
            p_Hours_Worked, 
            p_Unit_Price, 
            v_Line_Total 
        ); 
    ELSEIF UPPER(v_Contract_Type) = 'FIXED' THEN 
        IF p_Fixed_Term_ID IS NULL THEN 
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'For fixed contracts, Fixed_Term_ID is required'; 
        END IF; 
        SELECT Fixed_Price_Amount, Deliverable_Description 
        INTO v_Fixed_Price, v_Fixed_Description 
        FROM fixed_terms 
        WHERE Fixed_Term_ID = p_Fixed_Term_ID 
          AND Contract_ID = p_Contract_ID; 
        IF v_Fixed_Price IS NULL THEN 
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Invalid Fixed_Term_ID for the selected contract'; 
        END IF; 
        SET v_Line_Total = v_Fixed_Price; 
        INSERT INTO invoice ( 
            Invoice_ID, 
            Contract_ID, 
            Pay_ID, 
            Entity_ID, 
            Invoice_Date, 
            Total_Amount_Due, 
            Status 
        ) 
        VALUES ( 
            v_Invoice_ID, 
            p_Contract_ID, 
            p_Pay_ID, 
            v_Entity_ID, 
            p_Invoice_Date, 
            v_Line_Total, 
            'Invoiced' 
        ); 
        INSERT INTO invoice_line ( 
            Line_ID, 
            Invoice_ID, 
            Description, 
            Quantity_or_Hours, 
            Unit_Price, 
            Line_Total 
        ) 
        VALUES ( 
            v_Line_ID, 
            v_Invoice_ID, 
            COALESCE(p_Description, v_Fixed_Description), 
            1.00, 
            v_Fixed_Price, 
            v_Line_Total 
        ); 
    ELSE 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Unsupported Contract_Type'; 
    END IF; 
    SELECT 
        'Procedure executed successfully' AS Message, 
        v_Invoice_ID AS New_Invoice_ID, 
        v_Line_ID AS New_Line_ID, 
        p_Contract_ID AS Contract_ID, 
        v_Contract_Type AS Contract_Type, 
        v_Line_Total AS Total_Amount; 
END // 
DELIMITER ; 
