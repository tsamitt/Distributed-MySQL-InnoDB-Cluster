-- Sasmit Tomar Table --
CREATE TABLE rate_cards( 
    Rate_ID INT, 
    Location_ID INT, 
    Role_ID INT, 
    Hourly_Rate DECIMAL(10,2), 
    Currency_Code CHAR(3), 
    PRIMARY KEY (Rate_ID), 
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID), 
    FOREIGN KEY (Role_ID) REFERENCES Job_Role(Job_Role_ID) 
); 
-- Sasmit Tomar Table --
CREATE TABLE contracts( 
    Contract_ID INT, 
    Entity_ID INT, 
    Contract_Type VARCHAR(50), 
    Start_Date DATE, 
    End_Date DATE, 
    Investment_Amount DECIMAL(15,2), 
    PRIMARY KEY (Contract_ID), 
    FOREIGN KEY (Entity_ID) REFERENCES ENTITY(Entity_ID) 
); 

-- Sasmit Tomar Table --
CREATE TABLE hourly_terms( 
    Hourly_Term_ID INT, 
    Contract_ID INT, 
    Max_Labor_Hours INT, 
    Billing_Cycle VARCHAR(50), 
    PRIMARY KEY (Hourly_Term_ID), 
    FOREIGN KEY (Contract_ID) REFERENCES contracts(Contract_ID) 
); 

-- Sasmit Tomar Table --
CREATE TABLE fixed_terms( 
    Fixed_Term_ID INT, 
    Contract_ID INT, 
    Fixed_Price_Amount DECIMAL(15,2), 
    Deliverable_Description VARCHAR(255), 
    PRIMARY KEY (Fixed_Term_ID), 
    FOREIGN KEY (Contract_ID) REFERENCES contracts(Contract_ID) 
); 

-- Sasmit Tomar Table --
CREATE TABLE invoice( 
    Invoice_ID INT, 
    Contract_ID INT, 
    Pay_ID INT, 
    Entity_ID INT, 
    Invoice_Date DATE, 
    Total_Amount_Due DECIMAL(15,2), 
    Status VARCHAR(50), 
    PRIMARY KEY (Invoice_ID), 
    FOREIGN KEY (Contract_ID) REFERENCES contracts(Contract_ID), 
    FOREIGN KEY (Pay_ID) REFERENCES payment_method(Pay_ID), 
    FOREIGN KEY (Entity_ID) REFERENCES ENTITY(Entity_ID) 
); 

-- Sasmit Tomar Table --
CREATE TABLE invoice_line( 
    Line_ID INT, 
    Invoice_ID INT, 
    Description VARCHAR(255), 
    Quantity_or_Hours DECIMAL(10,2), 
    Unit_Price DECIMAL(10,2), 
    Line_Total DECIMAL(15,2), 
    PRIMARY KEY (Line_ID), 
    FOREIGN KEY (Invoice_ID) REFERENCES invoice(Invoice_ID) 
); 
