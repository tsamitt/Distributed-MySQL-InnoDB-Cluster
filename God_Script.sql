-- Zero Index God Script
CREATE SCHEMA IF NOT EXISTS ZeroIndex;
USE ZeroIndex;

/* Create Statements */
-- Elizabeth Luttmann Table --
CREATE TABLE ENTITY
(Entity_ID	INT NOT NULL AUTO_INCREMENT,
Entity_Type	Varchar(20),
PRIMARY KEY (ENTITY_ID));

-- Elizabeth Luttmann Table --
CREATE TABLE DEPARTMENT
(DEPARTMENT_ID INT PRIMARY KEY,
DEPARTMENT_NAME Varchar(50),
DEPARTMENT_CODE Varchar(5));

-- Elizabeth Luttmann Table --
CREATE TABLE ADDRESS
(Address_ID INT,
Entity_ID INT,
Address_Line1 Varchar(50),
City	Varchar(50),
State_Province	Varchar(50),
Postal_Code	Varchar(10),
Country_Code	Varchar(50),
PRIMARY KEY (ADDRESS_ID),
FOREIGN KEY (ENTITY_ID) REFERENCES ENTITY(ENTITY_ID));

-- Elizabeth Luttmann Table --
CREATE TABLE PHONE_NUMBER
(Phone_Number_ID INT,
Entity_ID INT,
PhoneNumber Varchar(15),
PRIMARY KEY (PHONE_NUMBER_ID),
FOREIGN KEY (ENTITY_ID) REFERENCES ENTITY(ENTITY_ID));

-- Tyson Shannon Table --
CREATE TABLE Country (
    Country_ID INT,
    Country_Name VARCHAR(255) NOT NULL,
    Country_Code CHAR(2) NOT NULL,
    Currency_Name VARCHAR(255),
    Currency_Code CHAR(3),
    PRIMARY KEY (Country_ID)
);

-- Tyson Shannon Table --
CREATE TABLE Labor_Policies (
    Labor_Policies_ID INT,
    Country_ID INT NOT NULL,
    Max_Weekly_Hrs DECIMAL(5,2),
    Max_Daily_Hrs DECIMAL(5,2),
    Max_Regular_Weekly_Hrs DECIMAL(5,2),
    Max_Regular_Daily_Hrs DECIMAL(5,2),
    OT_Rate_Multiplier DECIMAL(38,2),
    Policy_Date_Creation DATE,
    Policy_Active BOOLEAN,
    PRIMARY KEY (Labor_Policies_ID),
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);

-- Tyson Shannon Table --
CREATE TABLE Job_Role (
    Job_Role_ID INT,
    Job_Role_Title VARCHAR(255) NOT NULL,
    Job_Role_Level VARCHAR(255),
    OT_Eligibility BOOLEAN,
    PRIMARY KEY (Job_Role_ID)
);

-- Tyson Shannon Table --
CREATE TABLE Location (
    Location_ID INT,
    Country_ID INT NOT NULL,
    Entity_ID INT NOT NULL,
    Location_Name VARCHAR(255),
    Location_Time_Zone VARCHAR(50),
    PRIMARY KEY (Location_ID),
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID),
    FOREIGN KEY (Entity_ID) REFERENCES ENTITY(Entity_ID)
);

-- Elizabeth Luttmann Table --
CREATE TABLE EMPLOYEE 
(Entity_ID INT,
Location_ID INT,
Department_ID INT,
Job_Role_ID INT,
FirstName	Varchar(50),
LastName	Varchar(50),
Email Varchar(50),
Hire_Date DATE,
Employment_Status Varchar(50),
Salary	DECIMAL(15, 2),
PRIMARY KEY (ENTITY_ID),
FOREIGN KEY (ENTITY_ID) REFERENCES ENTITY(ENTITY_ID),
FOREIGN KEY (LOCATION_ID) REFERENCES Location(Location_ID),
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT(DEPARTMENT_ID));

-- Tyson Shannon Table --
CREATE TABLE Work_Schedule (
    Schedule_ID INT,
    Employee_ID INT NOT NULL,
    Location_ID INT NOT NULL,
    Shift_Start TIMESTAMP,
    Shift_End TIMESTAMP,
    Total_Hours DECIMAL(38,2),
    Is_OT BOOLEAN,
	PRIMARY KEY (Schedule_ID),
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Entity_ID),
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

-- Elizabeth Luttmann Table --
CREATE TABLE EMPLOYEE_HISTORY
(Entity_ID INT,
Location_ID INT,
Department_ID INT,
Job_Rate INT,
Start_Date DATE,
End_Date DATE,
FirstName	Varchar(50),
LastName	Varchar(50),
Salary	DECIMAL(15,2),
PRIMARY KEY (ENTITY_ID),
FOREIGN KEY (ENTITY_ID) REFERENCES ENTITY(ENTITY_ID));

-- Joseph Mueller Table --
CREATE TABLE Task_Category (
    Task_ID INT NOT NULL AUTO_INCREMENT,
    Category_Name VARCHAR(100) NOT NULL,
    Is_Billable TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (Task_ID)
);

-- Joseph Mueller Table --
CREATE TABLE User_Roles (
    User_Role_ID INT NOT NULL AUTO_INCREMENT,
    Role_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Permission_Level INT NOT NULL DEFAULT 1,
    PRIMARY KEY (User_Role_ID)
);

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

-- Joseph Mueller Table --
CREATE TABLE Timecard (
    Timecard_ID INT NOT NULL AUTO_INCREMENT,
    Entity_ID INT NULL,
    Schedule_ID INT NULL,
    Rate_ID INT NULL,
    Hours_Worked DECIMAL(6,2) NOT NULL DEFAULT 0.00,
    Pay_Period_Start DATE NOT NULL,
    Pay_Period_End DATE NOT NULL,
    Status VARCHAR(50)  NOT NULL DEFAULT 'Pending',
    Location_ID INT NULL,
    PRIMARY KEY (Timecard_ID),
    FOREIGN KEY (Entity_ID)   REFERENCES EMPLOYEE(Entity_ID),
    FOREIGN KEY (Schedule_ID) REFERENCES Work_Schedule(Schedule_ID),
    FOREIGN KEY (Rate_ID)     REFERENCES rate_cards(Rate_ID),
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

-- Joseph Mueller Table --
CREATE TABLE Overtime_Logs (
    Overtime_ID INT NOT NULL AUTO_INCREMENT,
    Timecard_ID INT NOT NULL,
    Labor_Policies_ID INT NULL,
    OT_Hours DECIMAL(6,2) NOT NULL DEFAULT 0.00,
    Approval_Manager  VARCHAR(100),
    PRIMARY KEY (Overtime_ID),
    FOREIGN KEY (Timecard_ID) REFERENCES Timecard(Timecard_ID),
    FOREIGN KEY (Labor_Policies_ID) REFERENCES Labor_Policies(Labor_Policies_ID)
);

-- Esrom Ghebrai Table --
CREATE TABLE PROJECTS (
    project_id INT PRIMARY KEY,
    project_code VARCHAR(10) NOT NULL UNIQUE,
    project_name VARCHAR(150) NOT NULL,
    client_name VARCHAR(150) NOT NULL,
    department VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    budget DECIMAL(12,2) NOT NULL,
    project_manager VARCHAR(120) NOT NULL
);

-- Joseph Mueller Table --
CREATE TABLE Timecard_Entries (
    Entry_ID INT NOT NULL AUTO_INCREMENT,
    Timecard_ID INT NOT NULL,
    Project_ID INT NULL,
    Task_ID INT NOT NULL,
    Entry_Date DATE NOT NULL,
    Hours_Accrued DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (Entry_ID),
    FOREIGN KEY (Timecard_ID) REFERENCES Timecard(Timecard_ID),
    FOREIGN KEY (Project_ID) REFERENCES PROJECTS(Project_ID),
    FOREIGN KEY (Task_ID) REFERENCES Task_Category(Task_ID)
);

-- Joseph Mueller Table --
CREATE TABLE Users (
    User_ID INT NOT NULL AUTO_INCREMENT,
    User_Role_ID INT NOT NULL,
    Entity_ID INT NULL,
    Username VARCHAR(100) NOT NULL UNIQUE,
    Password_Hash VARCHAR(255) NOT NULL,
    Account_Status VARCHAR(50)  NOT NULL DEFAULT 'Active',
    Preferred_Language VARCHAR(50)  NOT NULL DEFAULT 'English',
    Account_Created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (User_ID),
    FOREIGN KEY (User_Role_ID) REFERENCES User_Roles(User_Role_ID),
    FOREIGN KEY (Entity_ID) REFERENCES EMPLOYEE(Entity_ID)
);

-- Creston Dorothy Table --
CREATE TABLE organizations (
  Entity_ID INT NOT NULL,
  Org_Name VARCHAR(70) NULL,
  PRIMARY KEY (Entity_ID),
  UNIQUE (Org_Name),
  FOREIGN KEY (Entity_ID) REFERENCES ENTITY (Entity_ID)
);

-- Creston Dorothy Table --
CREATE TABLE product (
  Product_ID INT NOT NULL,
  Entity_ID INT NULL,
  Product_Name VARCHAR(50) NOT NULL,
  Product_Description VARCHAR(200) NULL,
  Product_Cost DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (Product_ID),
  UNIQUE (Product_Name),
  FOREIGN KEY (Entity_ID) REFERENCES ENTITY (Entity_ID)
 );

-- Creston Dorothy Table --
CREATE TABLE inventory (
  Product_ID INT NOT NULL,
  Country_ID INT NOT NULL,
  QOH INT NOT NULL,
  PRIMARY KEY (Product_ID, Country_ID),
  FOREIGN KEY (Product_ID) REFERENCES product (Product_ID),
  FOREIGN KEY (Country_ID) REFERENCES Country (Country_ID)
);

-- Creston Dorothy Table --
CREATE TABLE payment_method (
  Pay_ID INT NOT NULL,
  Payment_Type VARCHAR(50) NOT NULL,
  Pay_Description VARCHAR(45) NULL,
  Payment_Notes VARCHAR(200) NULL,
  PRIMARY KEY (Pay_ID),
  UNIQUE (Payment_Type)
 );
 
-- Creston Dorothy Table --
 CREATE TABLE org_alias (
  Alias_ID INT NOT NULL,
  Entity_ID INT NOT NULL,
  Alias_Name VARCHAR(70) NOT NULL,
  PRIMARY KEY (Alias_ID),
  UNIQUE (Entity_ID, Alias_Name),
  FOREIGN KEY (Entity_ID) REFERENCES ENTITY (Entity_ID)
 );
 
-- Creston Dorothy Table --
CREATE TABLE customers (
  Entity_ID INT NOT NULL,
  First_Name VARCHAR(50) NOT NULL,
  Last_Name VARCHAR(50) NOT NULL,
  PRIMARY KEY (Entity_ID),
  FOREIGN KEY (Entity_ID) REFERENCES ENTITY (Entity_ID)
 );
 
-- Creston Dorothy Table --
 CREATE TABLE client_contacts (
  Contact_ID INT NOT NULL,
  Client_ID INT NOT NULL,
  First_Name VARCHAR(50) NOT NULL,
  Last_Name VARCHAR(50) NOT NULL,
  Email VARCHAR(100) NULL,
  PRIMARY KEY (Contact_ID),
  FOREIGN KEY (Client_ID) REFERENCES ENTITY (Entity_ID)
 );
 
 -- Creston Dorothy Table --
 CREATE TABLE client_org_structure (
  Org_ID INT NOT NULL,
  Entity_ID INT NOT NULL,
  Parent_Org_ID INT NULL,
  PRIMARY KEY (Org_ID),
  FOREIGN KEY (Entity_ID) REFERENCES ENTITY (Entity_ID),
  FOREIGN KEY (Parent_Org_ID) REFERENCES client_org_structure (Org_ID)
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

-- Esrom Ghebrai Table --
CREATE TABLE PROJECT_TEAMS (
    team_id INT PRIMARY KEY,
    project_id INT NOT NULL,
    member_name VARCHAR(120) NOT NULL,
    role_name VARCHAR(80) NOT NULL,
    email VARCHAR(120) NOT NULL,
    allocation_pct DECIMAL(5,2) NOT NULL,
    joined_date DATE NOT NULL,
    FOREIGN KEY (project_id) REFERENCES PROJECTS(project_id)
);

-- Esrom Ghebrai Table --
CREATE TABLE PROJECT_MILESTONES (
    milestone_id INT PRIMARY KEY,
    project_id INT NOT NULL,
    milestone_name VARCHAR(150) NOT NULL,
    due_date DATE NOT NULL,
    completion_date DATE NULL,
    status VARCHAR(20) NOT NULL,
    deliverable VARCHAR(150) NOT NULL,
    FOREIGN KEY (project_id) REFERENCES PROJECTS(project_id)
);

-- Esrom Ghebrai Table --
CREATE TABLE COMPLIANCE_ALERTS (
    alert_id INT PRIMARY KEY,
    project_id INT NOT NULL,
    alert_date DATE NOT NULL,
    alert_type VARCHAR(100) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    description VARCHAR(255) NOT NULL,
    resolved_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (project_id) REFERENCES PROJECTS(project_id)
);

-- Esrom Ghebrai Table --
CREATE TABLE PROJECT_KPIs (
    kpi_id INT PRIMARY KEY,
    project_id INT NOT NULL,
    kpi_name VARCHAR(150) NOT NULL,
    target_value DECIMAL(10,2) NOT NULL,
    actual_value DECIMAL(10,2) NULL,
    measurement_unit VARCHAR(30) NOT NULL,
    reporting_period VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (project_id) REFERENCES PROJECTS(project_id)
);

-- Esrom Ghebrai Table --
CREATE TABLE PROJECT_ALLOCATION (
    allocation_id INT PRIMARY KEY,
    project_id INT NOT NULL,
    team_id INT NOT NULL,
    resource_type VARCHAR(100) NOT NULL,
    allocated_hours INT NOT NULL,
    allocation_start DATE NOT NULL,
    allocation_end DATE NOT NULL,
    allocation_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (project_id) REFERENCES PROJECTS(project_id),
    FOREIGN KEY (team_id) REFERENCES PROJECT_TEAMS(team_id)
);

COMMIT;

/* Insert Statements */
-- Elizabeth Luttmann Inserts --
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (1,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Business to Business');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Direct');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');
INSERT INTO ENTITY (ENTITY_ID, ENTITY_TYPE) VALUES (DEFAULT,'Employee');

-- Elizabeth Luttmann Inserts --
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (1,'Human Resources','HR');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (2,'Customer Service','CS');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (3,'Sales','SL');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (4,'Accounting','ACCT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (5,'Executive','EXE');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (6,'Information Tech','IT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (7,'Marketing','MKT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (8,'Human Resources','HR');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (9,'Customer Service','CS');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (10,'Sales','SL');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (11,'Accounting','ACCT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (12,'Executive','EXE');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (13,'Information Tech','IT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (14,'Marketing','MKT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (15,'Human Resources','HR');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (16,'Customer Service','CS');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (17,'Sales','SL');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (18,'Accounting','ACCT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (19,'Executive','EXE');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (20,'Information Tech','IT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (21,'Marketing','MKT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (22,'Human Resources','HR');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (23,'Customer Service','CS');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (24,'Sales','SL');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (25,'Accounting','ACCT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (26,'Executive','EXE');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (27,'Information Tech','IT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (28,'Marketing','MKT');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (29,'Executive','EXE');
INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME, DEPARTMENT_CODE) VALUES (30,'Information Tech','IT');

-- Elizabeth Luttmann Inserts --
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (1,1,'508 Pleasure Drive','Los Angeles','California','90020','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (2,2,'9 Golf View Pass','Los Angeles','California','90035','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (3,3,'20742 Pleasure Parkway','Los Angeles','California','90005','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (4,4,'8 Upham Trail','Los Angeles','California','90101','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (5,5,'869 Blackbird Terrace','Los Angeles','California','90065','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (6,6,'8619 Kensington Circle','Los Angeles','California','90025','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (7,7,'29 Cascade Drive','Los Angeles','California','90071','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (8,8,'4075 Summerview Alley','Los Angeles','California','90094','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (9,9,'844 Crescent Oaks Avenue','Los Angeles','California','90101','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (10,10,'9001 Hanover Street','Los Angeles','California','90015','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (11,11,'350 Harbort Junction','Los Angeles','California','90055','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (12,12,'60 Packers Pass','Los Angeles','California','90055','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (13,13,'95601 Riverside Way','Los Angeles','California','90076','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (14,14,'96264 Ryan Center','Los Angeles','California','90010','United States');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (15,15,'5948 Hudson Court','Hanjia',NULL,NULL,'China');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (16,16,'9053 Main Way','Licun',NULL,NULL,'China');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (17,17,'6292 Riverside Terrace','Malvinas Argentinas',NULL,'5125','Argentina');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (18,18,'5944 Sycamore Place','Leping',NULL,NULL,'China');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (19,19,'421 Moland Plaza','Huinca Renanca',NULL,'6270','Argentina');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (20,20,'3 Maryland Circle','Fengzhou',NULL,NULL,'China');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (21,21,'9 Leroy Way','Belleville','Ontario','K8P','Canada');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (22,22,'6598 Roxbury Point','Jinhui',NULL,NULL,'China');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (23,23,'8 Scott Plaza','Manning','Alberta','V3A','Canada');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (24,24,'137 Bultman Terrace','La Broquerie','Manitoba','L2G','Canada');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (25,25,'149 Buhler Hill','Rio Ceballos',NULL,'5113','Argentina');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (26,26,'28814 Waubesa Point','San Pedro',NULL,'4500','Argentina');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (27,27,'882 3rd Place','Zhitang',NULL,NULL,'China');
INSERT INTO ADDRESS (Address_ID, Entity_ID, Address_Line1, City, State_Province, Postal_Code, Country_Code) VALUES (28,28,'869 American Ash Way','Taling',NULL,NULL,'China');

-- Elizabeth Luttmann Inserts --
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (1,1,'545634326497');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (2,2,'549952466263');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (3,3,'545367563776');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (29,4,'5497585251373');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (4,5,'861017561528');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (5,6,'861064425035');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (6,7,'86105679753');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (7,8,'861092016454');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (8,9,'8686618644');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (9,10,'861090537870');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (10,11,'14085437267');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (11,12,'1661956971');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (12,13,'18056291216');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (13,14,'14155613560');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (14,15,'15622022475');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (15,16,'1916398576');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (16,17,'1831623374');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (17,18,'19517665308');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (18,19,'1916938543');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (19,20,'17146093568');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (20,21,'16198961450');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (21,22,'17141851534');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (22,23,'18053791483');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (23,24,'19225484354');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (24,25,'15096052266');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (25,26,'1692837156');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (26,27,'13212081455');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (27,28,'14757754749');
INSERT INTO PHONE_NUMBER (Phone_Number_ID, Entity_ID, PhoneNumber) VALUES (28,29,'19361861247');

-- Tyson Shannon Inserts --
INSERT INTO Country VALUES
(1,'United States','US','Dollar','USD'),
(2,'Canada','CA','Dollar','CAD'),
(3,'United Kingdom','GB','Pound','GBP'),
(4,'Germany','DE','Euro','EUR'),
(5,'France','FR','Euro','EUR'),
(6,'Japan','JP','Yen','JPY'),
(7,'China','CN','Yuan','CNY'),
(8,'India','IN','Rupee','INR'),
(9,'Australia','AU','Dollar','AUD'),
(10,'Argentina','AR','Peso','ARS'),
(11,'Mexico','MX','Peso','MXN'),
(12,'South Korea','KR','Won','KRW'),
(13,'Italy','IT','Euro','EUR'),
(14,'Spain','ES','Euro','EUR'),
(15,'Netherlands','NL','Euro','EUR'),
(16,'Sweden','SE','Krona','SEK'),
(17,'Norway','NO','Krone','NOK'),
(18,'Denmark','DK','Krone','DKK'),
(19,'Switzerland','CH','Franc','CHF'),
(20,'Singapore','SG','Dollar','SGD');

-- Tyson Shannon Inserts --
INSERT INTO Labor_Policies VALUES
(1,1,40,8,40,8,1.5,'2024-01-01',1),
(2,2,44,8,40,8,1.5,'2024-01-01',1),
(3,3,48,8,40,8,1.5,'2024-01-01',1),
(4,4,48,8,40,8,1.5,'2024-01-01',1),
(5,5,35,7,35,7,1.5,'2024-01-01',1),
(6,6,40,8,40,8,1.25,'2024-01-01',1),
(7,7,44,8,40,8,1.5,'2024-01-01',1),
(8,8,48,9,40,8,2.0,'2024-01-01',1),
(9,9,38,7.6,38,7.6,1.5,'2024-01-01',1),
(10,10,44,8,40,8,1.5,'2024-01-01',1),
(11,11,48,8,40,8,2.0,'2024-01-01',1),
(12,12,52,10,40,8,1.5,'2024-01-01',1),
(13,13,40,8,40,8,1.5,'2024-01-01',1),
(14,14,40,8,40,8,1.5,'2024-01-01',1),
(15,15,40,8,40,8,1.5,'2024-01-01',1),
(16,16,40,8,40,8,1.5,'2024-01-01',1),
(17,17,40,8,40,8,1.5,'2024-01-01',1),
(18,18,37,7.4,37,7.4,1.5,'2024-01-01',1),
(19,19,45,9,40,8,1.5,'2024-01-01',1),
(20,20,44,8,40,8,1.5,'2024-01-01',1);

-- Tyson Shannon Inserts --
INSERT INTO Job_Role VALUES
(1,'Software Engineer','Junior',1),
(2,'Software Engineer','Senior',1),
(3,'Manager','Mid',0),
(4,'HR Specialist','Junior',0),
(5,'HR Manager','Senior',0),
(6,'Data Analyst','Junior',1),
(7,'Data Scientist','Senior',1),
(8,'DevOps Engineer','Mid',1),
(9,'QA Engineer','Junior',1),
(10,'QA Lead','Senior',0),
(11,'Product Manager','Senior',0),
(12,'UX Designer','Mid',1),
(13,'Security Analyst','Mid',1),
(14,'Security Engineer','Senior',1),
(15,'Support Specialist','Junior',1),
(16,'Network Engineer','Mid',1),
(17,'Database Admin','Senior',1),
(18,'Intern','Entry',0),
(19,'Consultant','Senior',0),
(20,'Director','Executive',0);

-- Tyson Shannon Inserts --
INSERT INTO Location VALUES
(1,1,1,'NY Office','EST'),
(2,2,2,'Toronto Office','EST'),
(3,3,3,'London HQ','GMT'),
(4,4,4,'Berlin Office','CET'),
(5,5,5,'Paris Office','CET'),
(6,6,6,'Tokyo Office','JST'),
(7,7,7,'Beijing Office','CST'),
(8,8,8,'Delhi Office','IST'),
(9,9,9,'Sydney Office','AEST'),
(10,10,10,'Rio Office','BRT'),
(11,11,11,'Mexico City Office','CST'),
(12,12,12,'Seoul Office','KST'),
(13,13,13,'Rome Office','CET'),
(14,14,14,'Madrid Office','CET'),
(15,15,15,'Amsterdam Office','CET'),
(16,16,16,'Stockholm Office','CET'),
(17,17,17,'Oslo Office','CET'),
(18,18,18,'Copenhagen Office','CET'),
(19,19,19,'Zurich Office','CET'),
(20,20,20,'Singapore Office','SGT');

-- Elizabeth Luttmann Inserts --
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (1,1,1,1,'Cheri','Penlington','cpenlington0@tinypic.com','2025-04-28','Active','95780.79');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (2,2,2,2,'Carol-jean','Denecamp','cdenecamp1@ca.gov','2025-08-10','Active','110964.11');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (3,3,3,3,'Mariya','Kynman','mkynman2@blogspot.com','2025-12-01','Active','142846.82');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (4,4,4,4,'Lexi','Moakes','lmoakes3@booking.com','2025-07-05','Active','84416.34');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (5,5,5,5,'Quinton','Broodes','qbroodes4@disqus.com','2026-04-04','Active','96851.66');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (6,6,6,1,'Lillis','Strathdee','lstrathdee5@storify.com','2025-05-08','Active','119446.39');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (7,7,7,2,'Jaquenette','Strelitzer','jstrelitzer6@mtv.com','2026-03-01','Active','114091.47');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (8,8,1,3,'Anthe','Brinkley','abrinkley7@kickstarter.com','2025-05-10','Active','88263.33');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (9,9,2,4,'Sharron','Gerrell','sgerrell8@example.com','2026-02-15','Active','131396.12');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (10,10,3,5,'Kim','Costain','kcostain9@google.es','2026-01-31','Active','130656.43');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (11,11,4,1,'Kin','Vedeshkin','kvedeshkina@oaic.gov.au','2026-03-19','Active','102364.66');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (12,12,5,2,'Cchaddie','Behling','cbehlingb@wikispaces.com','2025-08-05','Active','90490.42');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (13,13,6,3,'Colin','Worters','cwortersc@360.cn','2025-11-09','Active','109676.06');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (14,14,7,4,'Genevra','Drissell','gdrisselld@blogger.com','2026-02-18','Active','148423.34');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (15,15,1,5,'Wilhelm','Moreman','wmoremane@360.cn','2025-09-21','Active','111352.29');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (16,16,2,1,'Ker','Hewins','khewinsf@issuu.com','2025-08-17','Active','136601.79');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (17,17,3,2,'Everett','Matyatin','ematyating@shareasale.com','2026-04-06','Active','149881.66');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (18,18,4,3,'Eve','Shucksmith','eshucksmithh@photobucket.com','2025-11-19','Active','108756.92');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (19,19,5,4,'Cissiee','Roseman','crosemani@yolasite.com','2025-06-24','Active','115034.46');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (20,1,6,5,'Giacopo','Pauletto','gpaulettoj@nifty.com','2025-06-17','Active','149311.8');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (21,2,7,1,'Adriana','Robillart','arobillartk@howstuffworks.com','2000-08-01','Active','136910.39');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (22,3,1,2,'Marleah','Covington','mcovingtonl@tamu.edu','2026-02-16','Active','81231.67');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (23,4,2,3,'Carolynn','Meffen','cmeffenm@webmd.com','2025-08-08','Active','98814.09');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (24,5,3,4,'Merilyn','Salterne','msalternen@mediafire.com','2025-08-24','Active','127606.07');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (25,6,4,5,'Waylan','Elgram','welgramo@ocn.ne.jp','2025-07-20','Active','89821.83');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (26,7,5,1,'Jodi','Longworth','jlongworthp@walmart.com','2025-07-03','Active','102148.46');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (27,8,6,2,'Nicko','Foard','nfoardq@ning.com','2026-02-26','Active','148380.21');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (28,9,7,3,'Elinor','Guillou','eguillour@bluehost.com','2025-08-31','Active','135581.83');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (29,10,1,4,'Claribel','Espinos','cespinoss@tumblr.com','2024-01-26','Active','104019.39');
INSERT INTO EMPLOYEE (Entity_ID, Location_ID, Department_ID, Job_Role_ID, FirstName, LastName, Email, Hire_Date, Employment_Status, Salary) VALUES (30,11,2,5,'Judd','Luparto','jlupartot@wp.com','2025-12-02','Active','113303.44');

-- Tyson Shannon Inserts --
INSERT INTO Work_Schedule VALUES
(1,1,1,'2025-01-01 09:00:00','2025-01-01 17:00:00',8,0),
(2,2,2,'2025-01-02 09:00:00','2025-01-02 18:00:00',9,1),
(3,3,3,'2025-01-03 08:00:00','2025-01-03 16:00:00',8,0),
(4,4,4,'2025-01-04 09:00:00','2025-01-04 19:00:00',10,1),
(5,5,5,'2025-01-05 09:00:00','2025-01-05 17:00:00',8,0),
(6,6,6,'2025-01-06 10:00:00','2025-01-06 18:00:00',8,0),
(7,7,7,'2025-01-07 09:00:00','2025-01-07 20:00:00',11,1),
(8,8,8,'2025-01-08 08:00:00','2025-01-08 16:00:00',8,0),
(9,9,9,'2025-01-09 09:00:00','2025-01-09 17:00:00',8,0),
(10,10,10,'2025-01-10 09:00:00','2025-01-10 18:00:00',9,1),
(11,11,11,'2025-01-11 09:00:00','2025-01-11 17:00:00',8,0),
(12,12,12,'2025-01-12 09:00:00','2025-01-12 19:00:00',10,1),
(13,13,13,'2025-01-13 08:00:00','2025-01-13 16:00:00',8,0),
(14,14,14,'2025-01-14 09:00:00','2025-01-14 17:00:00',8,0),
(15,15,15,'2025-01-15 09:00:00','2025-01-15 18:00:00',9,1),
(16,16,16,'2025-01-16 10:00:00','2025-01-16 18:00:00',8,0),
(17,17,17,'2025-01-17 09:00:00','2025-01-17 20:00:00',11,1),
(18,18,18,'2025-01-18 08:00:00','2025-01-18 16:00:00',8,0),
(19,19,19,'2025-01-19 09:00:00','2025-01-19 17:00:00',8,0),
(20,20,20,'2025-01-20 09:00:00','2025-01-20 18:00:00',9,1);

-- Elizabeth Luttmann Inserts --
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (1,1,3,'2022-12-31','2025-12-31','Karyn','Drake','82338.26');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (2,2,3,'2018-01-25','2020-01-25','Aurilia','Lowde','84223.36');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (3,3,3,'1999-05-25','2001-05-25','Gaby','Feldstein','85070.31');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (4,4,3,'2000-02-13','2023-02-13','Aurelia','Rathjen','85531.61');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (5,5,3,'2017-11-29','2023-11-29','Luciana','Vasilyonok','85923.3');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (6,6,3,'2023-09-11','2024-09-11','Terri-jo','Robel','86589.76');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (7,7,3,'1995-10-19','2003-10-19','Gretal','Revance','89574.25');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (8,8,4,'2011-08-07','2019-08-07','Agneta','Measor','97409.38');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (9,9,5,'2007-06-25','2017-06-25','Gallagher','Casale','102010.86');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (10,10,5,'2002-01-27','2022-01-27','Eugen','Mersh','103952.98');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (11,11,5,'2017-06-07','2022-06-07','Filberte','Kull','104997.77');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (12,12,5,'2018-05-28','2025-05-28','Lannie','Feeham','107622.38');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (13,13,5,'1995-03-02','2023-03-02','Kain','Thomkins','109631.74');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (14,14,6,'2025-10-07','2026-04-12','Andrej','Dewis','110509.24');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (15,15,6,'2010-01-06','2015-01-06','Poppy','Jurasek','110762.49');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (16,16,7,'1997-08-11','2005-08-11','Willard','Ruston','116807.38');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (17,17,7,'2000-05-29','2005-05-29','Aldo','Gingel','118744.62');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (18,18,7,'1996-09-29','2025-09-29','Ericha','Sallinger','119720.92');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (19,19,8,'2005-04-25','2015-04-25','Nonie','Cribbin','121784.21');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (20,1,8,'2016-02-05','2020-02-05','Min','Conichie','124575.28');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (21,2,8,'2023-07-14','2024-07-14','Rakel','Meaddowcroft','125533.77');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (22,3,8,'2025-11-09','2025-11-09','Gisella','Bonafant','126059.36');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (23,4,8,'2020-09-21','2023-09-21','Ertha','Peret','127682.47');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (24,5,8,'2024-11-15','2025-11-15','Halette','Bloggett','128022.29');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (25,6,8,'2003-09-19','2023-09-19','Elsinore','Alexandrescu','129340.47');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (26,7,9,'2021-12-08','2025-12-08','Morissa','Ortells','136222.96');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (27,8,9,'1993-05-28','2003-05-28','Benyamin','Durbyn','138482.47');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (28,9,10,'2002-02-03','2022-02-03','Fanya','Hunnable','143104.51');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (29,10,10,'2007-07-17','2017-07-17','Magdalena','Dockwray','146412.84');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (30,11,10,'2020-04-09','2021-04-09','Almire','Codeman','147888.05');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (31,12,10,'2002-11-25','2012-11-25','Consuela','Prestage','148176.36');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (32,13,10,'1997-01-07','2009-07-01','Elias','Langfield','148332.92');
INSERT INTO EMPLOYEE_HISTORY (Entity_ID, Location_ID, Job_Rate, Start_Date, End_Date, FirstName, LastName, Salary) VALUES (33,14,10,'1997-11-09','2006-11-09','Rosemarie','Bruyns','148355.76');

-- Joseph Mueller Inserts --
INSERT INTO Task_Category (Category_Name, Is_Billable) VALUES
    ('Development', 1),
    ('Design', 1),
    ('Testing / QA', 1),
    ('Project Management', 1),
    ('Internal Meetings', 0),
    ('Training', 0),
    ('Documentation', 1),
    ('Client Communication', 1),
    ('Code Review', 1),
    ('Database Administration', 1),
    ('DevOps / Deployment', 1),
    ('Security Audit', 1),
    ('Budget Planning', 0),
    ('Onboarding', 0),
    ('Research & Development', 1),
    ('Data Analysis', 1),
    ('User Acceptance Testing', 1),
    ('Technical Support', 1),
    ('Vendor Management', 0),
    ('Compliance Review', 0);

-- Joseph Mueller Inserts --
INSERT INTO User_Roles (Role_Name, Description, Permission_Level) VALUES
    ('System Administrator',  'Full system access', 5),
    ('HR Manager',  'Edits employee records and payroll approvals', 4),
    ('Project Manager', 'Oversees projects', 4),
    ('Finance Manager',  'Approves billing entries and views financial reports', 4),
    ('Senior Developer', 'Leads software development', 3),
    ('Developer',  'Creates software features + software maintenance', 3),
    ('QA Engineer', 'Runs tests and logs defects', 3),
    ('Business Analyst', 'Gathers requirements and builds BPFs', 3),
    ('DevOps Engineer', 'Manages CI/CD pipelines and infrastructure', 3),
    ('Database Administrator', 'DB maintenance, Optimizes Querrys', 3),
    ('UX Designer', 'Creates wireframes, prototypes, and user research', 3),
    ('Technical Writer', 'Produces technical documentation and user manuals', 2),
    ('Support Specialist', 'Deals with tier-1 and tier-2 IT tickets', 2),
    ('Junior Developer', 'Assists with junior development tasks ', 2),
    ('Data Analyst', 'Produces reports and dashboards', 2),
    ('Payroll Clerk', 'Overviews payroll entries', 2),
    ('Intern', 'Temporary access for onboarding and training tasks', 1),
    ('Auditor', 'Read-only access for potential audits', 1),
    ('Client Viewer', 'External read-only access to approved project reports', 1),
    ('Contractor',  'Limited access for assigned projects/tasks only', 2);

-- Sasmit Tomar Inserts --
INSERT INTO rate_cards (Rate_ID, Location_ID, Role_ID, Hourly_Rate, Currency_Code) VALUES 
(1, 1, 1, 150.00, 'USD'), (2, 1, 2, 85.00, 'USD'), (3, 1, 3, 95.00, 'USD'), (4, 1, 4, 70.00, 'USD'), 
(5, 2, 1, 22500.00, 'JPY'), (6, 2, 2, 12000.00, 'JPY'), (7, 2, 3, 14500.00, 'JPY'), (8, 2, 4, 9000.00, 'JPY'), 
(9, 3, 1, 18000.00, 'ARS'), (10, 3, 2, 9500.00, 'ARS'), (11, 3, 3, 11000.00, 'ARS'), (12, 3, 4, 7500.00, 'ARS'), 
(13, 1, 5, 200.00, 'USD'), (14, 2, 5, 30000.00, 'JPY'), (15, 3, 5, 25000.00, 'ARS'), (16, 1, 1, 155.00, 'USD'), 
(17, 2, 2, 12500.00, 'JPY'), (18, 3, 3, 11500.00, 'ARS'), (19, 1, 4, 72.00, 'USD'), (20, 2, 5, 31000.00, 'JPY'); 

-- Joseph Mueller Inserts --
INSERT INTO Timecard
    (Entity_ID, Schedule_ID, Rate_ID, Hours_Worked,
     Pay_Period_Start, Pay_Period_End, Status, Location_ID)
VALUES
    (1, 1, 1, 40.00, '2025-01-01', '2025-01-14', 'Approved', 1),
    (2, 2, 2, 38.50, '2025-01-01', '2025-01-14', 'Approved', 2),
    (3, 3, 3, 47.00, '2025-01-01', '2025-01-14', 'Approved', 3),
    (4, 4, 4, 40.00, '2025-01-01', '2025-01-14', 'Approved', 4),
    (5, 5, 5, 20.00, '2025-01-01', '2025-01-14', 'Approved', 5),
    (6, 6, 6, 45.50, '2025-01-01', '2025-01-14', 'Submitted', 6),
    (7, 7, 7, 32.00, '2025-01-01', '2025-01-14', 'Approved', 7),
    (8, 8, 8, 40.00, '2025-01-01', '2025-01-14', 'Pending', 8),
    (9, 9, 9, 36.00, '2025-01-01', '2025-01-14', 'Approved', 9),
    (10, 10, 10, 42.50, '2025-01-01', '2025-01-14', 'Approved', 10),
    (11, 11, 11, 40.00, '2025-01-15', '2025-01-28', 'Approved', 11),
    (12, 12, 12, 44.00, '2025-01-15', '2025-01-28', 'Approved', 12),
    (13, 13, 13, 50.00, '2025-01-15', '2025-01-28', 'Approved', 13),
    (14, 14, 14, 38.00, '2025-01-15', '2025-01-28', 'Submitted', 14),
    (15, 15, 15, 20.00, '2025-01-15', '2025-01-28', 'Approved', 15),
    (16, 16, 16, 40.00, '2025-01-15', '2025-01-28', 'Approved', 16),
    (17, 17, 17, 43.00, '2025-01-15', '2025-01-28', 'Approved', 17),
    (18, 18, 18, 35.00, '2025-01-15', '2025-01-28', 'Pending', 18),
    (19, 19, 19, 48.00, '2025-01-15', '2025-01-28', 'Approved', 19),
    (20, 20, 20, 40.00, '2025-01-15', '2025-01-28', 'Rejected', 20);

-- Joseph Mueller Inserts --
INSERT INTO Overtime_Logs
    (Timecard_ID, Labor_Policies_ID, OT_Hours, Approval_Manager)
VALUES
    (3, 1, 7.00, 'Sandra Nguyen'),
    (6, 2, 5.50, 'James Carter'),
    (10, 3, 2.50, 'Sandra Nguyen'),
    (13, 4, 10.00, 'James Carter'),
    (17, 5, 3.00, 'Sandra Nguyen'),
    (19, 6, 8.00, 'James Carter'),
    (12, 7, 4.00, 'Rachel Kim'),
    (3, 8, 2.00, 'Sandra Nguyen'),
    (1, 9, 0.00, 'Sandra Nguyen'),
    (4, 10, 0.00, 'James Carter'),
    (11, 11, 0.00, 'Rachel Kim'),
    (16, 12, 0.00, 'Sandra Nguyen'),
    (5, 13, 0.00, 'James Carter'),
    (2, 14, 0.00, 'Rachel Kim'),
    (7, 15, 0.00, 'Sandra Nguyen'),
    (9, 16, 0.00, 'James Carter'),
    (14, 17, 0.00, 'Rachel Kim'),
    (18, 18, 0.00, 'Sandra Nguyen'),
    (15, 19, 0.00, 'James Carter'),
    (20, 20, 0.00, 'Rachel Kim');
    
-- Esrom Ghebrai Inserts --
INSERT INTO PROJECTS (project_id, project_code, project_name, client_name, department, start_date, end_date, status, budget, project_manager) VALUES
(1, 'P001', 'ERP Upgrade Phase 1', 'Northwind Retail', 'Enterprise Apps', '2025-01-10', '2025-05-30', 'Completed', 250000.00, 'Aisha Khan'),
(2, 'P002', 'Customer Portal Revamp', 'BluePeak Insurance', 'Digital Experience', '2025-02-01', '2025-07-15', 'In Progress', 180000.00, 'Miguel Torres'),
(3, 'P003', 'Warehouse Analytics Dashboard', 'LogiChain Supply', 'Operations', '2025-01-20', '2025-06-20', 'On Hold', 145000.00, 'Priya Nair'),
(4, 'P004', 'Cybersecurity Hardening', 'FinSecure Bank', 'Security', '2025-03-01', '2025-08-01', 'In Progress', 220000.00, 'Jordan Lee'),
(5, 'P005', 'Mobile Sales App', 'Vertex Foods', 'Sales', '2025-02-10', '2025-06-10', 'Completed', 125000.00, 'Sara Ahmed'),
(6, 'P006', 'HR Self-Service Portal', 'Contoso Manufacturing', 'Human Resources', '2025-01-15', '2025-04-30', 'Completed', 95000.00, 'Daniel Chen'),
(7, 'P007', 'Inventory Forecasting Model', 'Apex Distributors', 'Supply Chain', '2025-03-05', '2025-09-30', 'In Progress', 210000.00, 'Nina Patel'),
(8, 'P008', 'Cloud Migration Wave 2', 'MetroHealth Systems', 'Infrastructure', '2025-02-20', '2025-11-15', 'Planned', 500000.00, 'Liam O''Connor'),
(9, 'P009', 'Supplier Compliance Tracker', 'GreenField Energy', 'Procurement', '2025-01-25', '2025-05-25', 'Completed', 130000.00, 'Olivia Moore'),
(10, 'P010', 'Data Lake Governance', 'Summit Telecom', 'Data Platform', '2025-03-10', '2025-10-10', 'In Progress', 275000.00, 'Ethan Wright'),
(11, 'P011', 'Field Service Optimization', 'Orbit Utilities', 'Field Operations', '2025-02-05', '2025-07-05', 'Completed', 160000.00, 'Maya Singh'),
(12, 'P012', 'Payroll Automation', 'Harbor Logistics', 'Finance', '2025-01-18', '2025-04-18', 'Completed', 110000.00, 'Kevin Brown'),
(13, 'P013', 'CRM Integration', 'Nova Education', 'Customer Success', '2025-03-01', '2025-08-30', 'In Progress', 195000.00, 'Zara Ali'),
(14, 'P014', 'API Gateway Modernization', 'Pioneer Media', 'Integration', '2025-02-12', '2025-09-12', 'Planned', 240000.00, 'Henry Davis'),
(15, 'P015', 'E-commerce Search Upgrade', 'Crestline Apparel', 'Digital Commerce', '2025-01-22', '2025-06-22', 'Completed', 175000.00, 'Emma Wilson'),
(16, 'P016', 'Regulatory Reporting Suite', 'Evergreen Pharma', 'Compliance', '2025-03-15', '2025-12-15', 'In Progress', 320000.00, 'Noah Martinez'),
(17, 'P017', 'Data Center Resilience Test', 'Quantum Electronics', 'Infrastructure', '2025-02-25', '2025-05-25', 'Completed', 80000.00, 'Sophia Johnson'),
(18, 'P018', 'Document Management Cleanup', 'Cobalt Finance', 'Records Management', '2025-01-28', '2025-05-28', 'On Hold', 90000.00, 'Jack Taylor'),
(19, 'P019', 'Vendor Portal Rollout', 'Harborview Hotels', 'Procurement', '2025-04-01', '2025-09-01', 'Planned', 150000.00, 'Amelia Scott'),
(20, 'P020', 'Sustainability Metrics Dashboard', 'Everest Chemicals', 'ESG', '2025-03-20', '2025-10-20', 'In Progress', 170000.00, 'Benjamin Clark');

-- Joseph Mueller Inserts --
INSERT INTO Timecard_Entries
    (Timecard_ID, Project_ID, Task_ID, Entry_Date, Hours_Accrued)
VALUES
    (1, 1, 1,  '2025-01-02', 8.00),
    (1, 2, 3,  '2025-01-03', 8.00),
    (2, 3, 2,  '2025-01-02', 7.50),
    (2, 4, 11, '2025-01-03', 8.00),
    (3, 5, 1,  '2025-01-06', 9.00),
    (3, 6, 9,  '2025-01-07', 9.00),
    (4, 7, 4,  '2025-01-02', 8.00),
    (4, 8, 5,  '2025-01-03', 8.00),
    (5, 9, 14, '2025-01-06', 5.00),
    (5, 10, 2,  '2025-01-07', 5.00),
    (6, 11, 1,  '2025-01-02', 9.50),
    (6, 12, 7,  '2025-01-03', 9.00),
    (7, 13, 15, '2025-01-06', 8.00),
    (8, 14, 5,  '2025-01-07', 8.00),
    (9, 15, 16, '2025-01-02', 9.00),
    (10, 16, 1,  '2025-01-03', 8.50),
    (11, 17, 3,  '2025-01-15', 8.00),
    (12, 18, 8,  '2025-01-16', 9.00),
    (13, 19, 1,  '2025-01-15', 10.00),
    (14, 20, 4,  '2025-01-16', 8.00);

-- Joseph Mueller Inserts --
INSERT INTO Users
    (User_Role_ID, Entity_ID, Username, Password_Hash,
     Account_Status, Preferred_Language, Account_Created)
VALUES
    (1, 1, 'sys.admin', '$2b$12$KIXzRi6dFf7r8bQKuZ9eNe.placeholder.hashAAAAAAAAAAA', 'Active', 'English', '2023-01-01 08:00:00'),
    (2, 2, 'hr.manager1', '$2b$12$L2YxzQj5Gh8s9cRLvA0fOe.placeholder.hashBBBBBBBBBBB', 'Active', 'English', '2023-02-10 08:00:00'),
    (3, 3, 'pm.johnson', '$2b$12$M3ZyARk6Hi9t0dSMwB1gPf.placeholder.hashCCCCCCCCCCC', 'Active', 'English',  '2023-03-15 09:00:00'),
    (4, 4, 'fin.nguyen', '$2b$12$N4AbBSl7Ij0u1eTNxC2hQg.placeholder.hashDDDDDDDDDDD', 'Active', 'Vietnamese', '2023-04-01 08:30:00'),
    (5, 5, 'dev.senior1', '$2b$12$O5BcCTm8Jk1v2fUOyD3iRh.placeholder.hashEEEEEEEEEEE', 'Active', 'English', '2023-05-20 10:00:00'),
    (6, 6, 'dev.martinez', '$2b$12$P6CdDUn9Kl2w3gVPzE4jSi.placeholder.hashFFFFFFFFFFF', 'Active', 'Spanish', '2023-06-01 08:00:00'),
    (7, 7, 'qa.smith', '$2b$12$Q7DeDVo0Lm3x4hWQAF5kTj.placeholder.hashGGGGGGGGGGG', 'Active', 'English', '2023-06-15 08:00:00'),
    (8, 8, 'ba.wilson', '$2b$12$R8EfEWp1Mn4y5iXRBG6lUk.placeholder.hashHHHHHHHHHHH', 'Active', 'English', '2023-07-01 09:00:00'),
    (9, 9, 'devops.lee', '$2b$12$S9FgFXq2No5z6jYSCH7mVl.placeholder.hashIIIIIIIIIII', 'Active', 'Korean', '2023-07-10 08:00:00'),
    (10, 10, 'dba.brown', '$2b$12$T0GhGYr3Op6A7kZTDI8nWm.placeholder.hashJJJJJJJJJJJ', 'Active', 'English', '2023-08-01 08:00:00'),
    (11, 11, 'ux.garcia', '$2b$12$U1HiHZs4Pq7B8lAUEJ9oXn.placeholder.hashKKKKKKKKKKK', 'Active', 'Spanish', '2023-08-20 10:00:00'),
    (12, 12, 'tw.patel', '$2b$12$V2IjIAt5Qr8C9mBVFK0pYo.placeholder.hashLLLLLLLLLLL', 'Active', 'Hindi', '2023-09-05 08:00:00'),
    (13, 13, 'sup.thomas', '$2b$12$W3JkJBu6Rs9D0nCWGL1qZp.placeholder.hashMMMMMMMMMMM', 'Active', 'English', '2023-09-15 09:00:00'),
    (14, 14, 'jrdev.chen', '$2b$12$X4KlKCv7St0E1oDXHM2rAq.placeholder.hashNNNNNNNNNNN', 'Active', 'Mandarin', '2024-01-10 10:00:00'),
    (15, 15, 'analyst.davis', '$2b$12$Y5LmLDw8Tu1F2pEYIN3sBr.placeholder.hashOOOOOOOOOOO', 'Active', 'English',  '2024-02-01 08:00:00'),
    (16, 16, 'payroll.moore', '$2b$12$Z6MnMEx9Uv2G3qFZJO4tCs.placeholder.hashPPPPPPPPPPP', 'Active', 'English', '2024-02-15 08:30:00'),
    (17, 17, 'intern.taylor', '$2b$12$A7NoNFy0Vw3H4rGAKP5uDt.placeholder.hashQQQQQQQQQQQ', 'Active', 'English', '2024-05-15 09:00:00'),
    (18, 18, 'audit.jackson','$2b$12$B8OpOGz1Wx4I5sHBLQ6vEu.placeholder.hashRRRRRRRRRRR', 'Inactive', 'English', '2024-06-01 08:00:00'),
    (19, 19, 'client.view1', '$2b$12$C9PqPHA2Xy5J6tICMR7wFv.placeholder.hashSSSSSSSSSSS', 'Active', 'French', '2024-07-10 11:00:00'),
    (20, 20, 'contractor.rx', '$2b$12$D0QrQIB3Yz6K7uJDNS8xGw.placeholder.hashTTTTTTTTTTT', 'Active', 'English',  '2024-08-01 08:00:00');

-- Creston Dorothy Inserts --
INSERT INTO organizations (Entity_ID, Org_Name) VALUES
(1, 'Northwind Retail'),
(2, 'BluePeak Insurance'),
(3, 'LogiChain Supply'),
(4, 'FinSecure Bank'),
(5, 'Vertex Foods'),
(6, 'Contoso Manufacturing'),
(7, 'Apex Health Group'),
(8, 'Summit Energy'),
(9, 'GreenLeaf Pharma'),
(10, 'SkyBridge Telecom'),
(11, 'Riverstone Logistics'),
(12, 'IronCore Systems'),
(13, 'Nova Education'),
(14, 'Pulse Media'),
(15, 'BrightPath Consulting'),
(16, 'Crescent Automotive'),
(17, 'Prime Harbor Holdings'),
(18, 'Everfield Analytics'),
(19, 'Titan Industrial'),
(20, 'Silverline Services');

-- Creston Dorothy Inserts --
INSERT INTO product (Product_ID, Entity_ID, Product_Name, Product_Description, Product_Cost) VALUES
(1, 1, 'ERP Suite License', 'Enterprise resource planning annual software license', 12000.00),
(2, 2, 'Claims Portal Module', 'Insurance claims self-service portal module', 8500.00),
(3, 3, 'Warehouse Dashboard', 'Analytics dashboard for warehouse operations', 6400.00),
(4, 4, 'Security Audit Package', 'Cybersecurity hardening and audit package', 15000.00),
(5, 5, 'Mobile Sales App', 'Field sales mobile application subscription', 9800.00),
(6, 6, 'HR Self-Service Portal', 'Employee HR self-service web portal', 7200.00),
(7, 7, 'Telehealth Scheduler', 'Appointment and virtual visit scheduling software', 9300.00),
(8, 8, 'Energy Usage Tracker', 'Utility and energy consumption tracking platform', 5600.00),
(9, 9, 'Compliance Monitor', 'Regulatory compliance monitoring toolkit', 6700.00),
(10, 10, 'Network Operations Console', 'Telecom network operations management console', 11100.00),
(11, 11, 'Fleet Route Optimizer', 'Logistics route optimization application', 8800.00),
(12, 12, 'Infrastructure Monitor', 'Server and infrastructure health monitoring', 7600.00),
(13, 13, 'Learning Management Platform', 'Educational content and student tracking platform', 8900.00),
(14, 14, 'Campaign Analytics Suite', 'Digital media campaign performance analytics', 6100.00),
(15, 15, 'Consulting Engagement Pack', 'Bundle for client reporting and consulting deliverables', 4300.00),
(16, 16, 'Dealer Inventory Hub', 'Automotive inventory visibility platform', 9700.00),
(17, 17, 'Executive KPI Dashboard', 'Leadership dashboard for strategic KPIs', 5400.00),
(18, 18, 'Forecasting Engine', 'Predictive analytics and demand forecasting engine', 10200.00),
(19, 19, 'Plant Maintenance Scheduler', 'Industrial maintenance planning software', 7800.00),
(20, 20, 'Service Desk Portal', 'Customer support and internal service desk portal', 5000.00);

-- Creston Dorothy Inserts --
INSERT INTO inventory (Product_ID, Country_ID, QOH) VALUES
(1, 1, 25),
(2, 2, 18),
(3, 3, 14),
(4, 4, 10),
(5, 5, 16),
(6, 6, 22),
(7, 7, 30),
(8, 8, 27),
(9, 9, 13),
(10, 10, 11),
(11, 11, 19),
(12, 12, 24),
(13, 13, 15),
(14, 14, 20),
(15, 15, 17),
(16, 16, 12),
(17, 17, 9),
(18, 18, 21),
(19, 19, 8),
(20, 20, 26),
(1, 2, 12),
(1, 5, 9),
(1, 10, 14),
(2, 1, 7),
(2, 6, 11),
(2, 12, 8),
(3, 4, 13),
(3, 8, 10),
(3, 15, 6),
(4, 1, 5),
(4, 7, 8),
(4, 14, 7),
(5, 3, 16),
(5, 9, 12),
(5, 20, 9),
(6, 2, 14),
(6, 11, 10),
(6, 18, 8),
(7, 5, 11),
(7, 10, 13),
(7, 19, 6),
(8, 1, 20),
(8, 6, 15),
(8, 13, 9),
(9, 4, 7),
(9, 8, 12),
(9, 16, 10),
(10, 2, 9),
(10, 7, 6),
(10, 17, 5),
(11, 3, 14),
(11, 12, 11),
(11, 20, 13),
(12, 5, 10),
(12, 9, 8),
(12, 14, 12),
(13, 1, 11),
(13, 6, 7),
(13, 18, 9),
(14, 2, 15),
(14, 10, 10),
(14, 19, 8),
(15, 4, 18),
(15, 11, 12),
(15, 17, 7),
(16, 3, 9),
(16, 8, 14),
(16, 20, 10),
(17, 5, 13),
(17, 12, 8),
(17, 16, 11),
(18, 1, 6),
(18, 7, 9),
(18, 15, 12),
(19, 2, 10),
(19, 9, 7),
(19, 13, 5),
(20, 4, 16),
(20, 11, 14),
(20, 18, 10);

-- Creston Dorothy Inserts --
 INSERT INTO payment_method (Pay_ID, Payment_Type, Pay_Description, Payment_Notes) VALUES
 (1, 'Credit Card', 'Visa, MasterCard, American Express, etc.', NULL),
 (2, 'Wire Transfer', 'Online bank wire transfer', NULL),
 (3, 'Paypal', 'Pay online using paypal', NULL),
 (4, 'Gift Card', 'Vouchers and prepaid cards', NULL),
 (5, 'Internal Credit', 'Employee credit/transfer/other', NULL);

-- Creston Dorothy Inserts --
INSERT INTO org_alias (Alias_ID, Entity_ID, Alias_Name) VALUES
(1, 1, 'Northwind'),
(2, 2, 'BluePeak'),
(3, 3, 'LogiChain'),
(4, 4, 'FinSecure'),
(5, 5, 'Vertex'),
(6, 6, 'Contoso'),
(7, 7, 'Apex Health'),
(8, 8, 'Summit Energy'),
(9, 9, 'GreenLeaf'),
(10, 10, 'SkyBridge'),
(11, 11, 'Riverstone'),
(12, 12, 'IronCore'),
(13, 13, 'Nova Ed'),
(14, 14, 'Pulse Media'),
(15, 15, 'BrightPath'),
(16, 16, 'Crescent Auto'),
(17, 17, 'Prime Harbor'),
(18, 18, 'Everfield'),
(19, 19, 'Titan Industrial'),
(20, 20, 'Silverline');

-- Creston Dorothy Inserts --
INSERT INTO customers (Entity_ID, First_Name, Last_Name) VALUES
(37, 'Mason', 'Brooks'),
(38, 'Olivia', 'Reed'),
(39, 'Liam', 'Turner'),
(40, 'Sophia', 'Hayes'),
(41, 'Noah', 'Bennett'),
(42, 'Emma', 'Parker'),
(43, 'Lucas', 'Mitchell'),
(44, 'Ava', 'Cook'),
(45, 'Ethan', 'Ward'),
(46, 'Isabella', 'Bailey'),
(47, 'James', 'Murphy'),
(48, 'Mia', 'Powell'),
(49, 'Benjamin', 'Flores'),
(50, 'Charlotte', 'Price'),
(51, 'Henry', 'Kelly'),
(52, 'Amelia', 'Long'),
(53, 'Alexander', 'Perry'),
(54, 'Harper', 'Patterson'),
(55, 'Daniel', 'Hughes'),
(56, 'Evelyn', 'Coleman');

-- Creston Dorothy Inserts --
INSERT INTO client_contacts (Contact_ID, Client_ID, First_Name, Last_Name, Email) VALUES
(1, 1, 'Aisha', 'Khan', 'aisha.khan@northwindretail.com'),
(2, 2, 'Miguel', 'Torres', 'miguel.torres@bluepeakinsurance.com'),
(3, 3, 'Priya', 'Nair', 'priya.nair@logichain.com'),
(4, 4, 'Jordan', 'Lee', 'jordan.lee@finsecurebank.com'),
(5, 5, 'Sara', 'Ahmed', 'sara.ahmed@vertexfoods.com'),
(6, 6, 'Daniel', 'Chen', 'daniel.chen@contosomfg.com'),
(7, 7, 'Rachel', 'Kim', 'rachel.kim@apexhealthgroup.com'),
(8, 8, 'Marcus', 'Hill', 'marcus.hill@summitenergy.com'),
(9, 9, 'Nina', 'Patel', 'nina.patel@greenleafpharma.com'),
(10, 10, 'Owen', 'Scott', 'owen.scott@skybridgetelecom.com'),
(11, 11, 'Leah', 'Adams', 'leah.adams@riverstonelogistics.com'),
(12, 12, 'Tyler', 'Baker', 'tyler.baker@ironcoresystems.com'),
(13, 13, 'Grace', 'Evans', 'grace.evans@novaeducation.com'),
(14, 14, 'Victor', 'Ramirez', 'victor.ramirez@pulsemedia.com'),
(15, 15, 'Hannah', 'Cooper', 'hannah.cooper@brightpathconsulting.com'),
(16, 16, 'Caleb', 'Diaz', 'caleb.diaz@crescentauto.com'),
(17, 17, 'Zoe', 'Richardson', 'zoe.richardson@primeharbor.com'),
(18, 18, 'Isaac', 'Cox', 'isaac.cox@everfieldanalytics.com'),
(19, 19, 'Lucy', 'Howard', 'lucy.howard@titanindustrial.com'),
(20, 20, 'Nathan', 'Ward', 'nathan.ward@silverlineservices.com');

-- Creston Dorothy Inserts --
INSERT INTO client_org_structure (Org_ID, Entity_ID, Parent_Org_ID) VALUES
(1, 1, NULL),
(2, 2, NULL),
(3, 3, 1),
(4, 4, 1),
(5, 5, 2),
(6, 6, 2),
(7, 7, 3),
(8, 8, 3),
(9, 9, 4),
(10, 10, 4),
(11, 11, 5),
(12, 12, 5),
(13, 13, 6),
(14, 14, 6),
(15, 15, 7),
(16, 16, 8),
(17, 17, 9),
(18, 18, 10),
(19, 19, 11),
(20, 20, 12);

-- Sasmit Tomar Inserts --
INSERT INTO contracts (Contract_ID, Entity_ID, Contract_Type, Start_Date, End_Date, Investment_Amount) VALUES 
(1, 1, 'Hourly', '2026-01-01', '2026-12-31', 50000.00), 
(2, 2, 'Fixed', '2026-01-15', '2026-06-15', 25000.00), 
(3, 3, 'Hourly', '2026-02-01', '2026-08-01', 15000.00), 
(4, 4, 'Fixed', '2026-02-10', '2026-12-10', 45000.00), 
(5, 5, 'Hourly', '2026-03-01', '2027-03-01', 120000.00), 
(6, 6, 'Fixed', '2026-03-15', '2026-09-15', 30000.00), 
(7, 7, 'Hourly', '2026-04-01', '2026-10-01', 20000.00), 
(8, 8, 'Fixed', '2026-04-10', '2026-12-10', 60000.00), 
(9, 9, 'Hourly', '2026-05-01', '2026-11-01', 35000.00), 
(10, 10, 'Fixed', '2026-05-20', '2026-08-20', 12000.00), 
(11, 11, 'Hourly', '2026-06-01', '2026-12-01', 80000.00), 
(12, 12, 'Fixed', '2026-06-15', '2027-01-15', 55000.00), 
(13, 13, 'Hourly', '2026-07-01', '2027-07-01', 200000.00), 
(14, 14, 'Fixed', '2026-07-20', '2026-10-20', 18000.00), 
(15, 15, 'Hourly', '2026-08-01', '2027-02-01', 40000.00), 
(16, 16, 'Fixed', '2026-08-15', '2026-12-15', 22000.00), 
(17, 17, 'Hourly', '2026-09-01', '2027-03-01', 65000.00), 
(18, 18, 'Fixed', '2026-09-10', '2027-09-10', 95000.00), 
(19, 19, 'Hourly', '2026-10-01', '2027-04-01', 28000.00), 
(20, 20, 'Fixed', '2026-10-20', '2027-01-20', 15000.00); 

-- Sasmit Tomar Inserts --
INSERT INTO hourly_terms (Hourly_Term_ID, Contract_ID, Max_Labor_Hours, Billing_Cycle) VALUES 
(1, 1, 160, 'Monthly'), (2, 3, 80, 'Bi-Weekly'), (3, 5, 500, 'Monthly'), (4, 7, 100, 'Weekly'), 
(5, 9, 200, 'Monthly'), (6, 11, 300, 'Monthly'), (7, 13, 1000, 'Monthly'), (8, 15, 150, 'Bi-Weekly'), 
(9, 17, 250, 'Monthly'), (10, 19, 120, 'Weekly'), (11, 1, 40, 'Weekly'), (12, 3, 200, 'Monthly'), 
(13, 5, 600, 'Monthly'), (14, 7, 50, 'Weekly'), (15, 9, 180, 'Monthly'), (16, 11, 400, 'Monthly'), 
(17, 13, 1200, 'Monthly'), (18, 15, 90, 'Bi-Weekly'), (19, 17, 300, 'Monthly'), (20, 19, 150, 'Monthly'); 

-- Sasmit Tomar Inserts --
INSERT INTO fixed_terms (Fixed_Term_ID, Contract_ID, Fixed_Price_Amount, Deliverable_Description) VALUES 
(1, 2, 12500.00, 'Social Media Strategy Audit'), (2, 4, 20000.00, 'Website Redesign Phase 1'), 
(3, 6, 15000.00, 'SEO Strategy Implementation'), (4, 8, 30000.00, 'Market Expansion Report'), 
(5, 10, 6000.00, 'Email Marketing Automation'), (6, 12, 25000.00, 'PPC Campaign Setup'), 
(7, 14, 9000.00, 'Influencer Outreach Plan'), (8, 16, 11000.00, 'Brand Guidelines Dev'), 
(9, 18, 45000.00, 'E-commerce Integration'), (10, 20, 7500.00, 'UX/UI Review Report'), 
(11, 2, 12500.00, 'Final Campaign Launch'), (12, 4, 25000.00, 'Mobile App Prototype'), 
(13, 6, 15000.00, 'Content Strategy Pack'), (14, 8, 30000.00, 'Analytics Dashboard'), 
(15, 10, 6000.00, 'Social Media Training'), (16, 12, 30000.00, 'Global SEO Rollout'), 
(17, 14, 9000.00, 'Quarterly PR Support'), (18, 16, 11000.00, 'Copywriting Package'), 
(19, 18, 50000.00, 'Data Security Protocol'), (20, 20, 7500.00, 'Video Ad Production'); 

-- Sasmit Tomar Inserts --
INSERT INTO invoice (Invoice_ID, Contract_ID, Invoice_Date, Total_Amount_Due, Status) VALUES 
(1, 1, '2026-02-01', 4500.00, 'Invoiced'), (2, 2, '2026-02-15', 12500.00, 'Active'), 
(3, 3, '2026-03-01', 2200.00, 'Invoiced'), (4, 4, '2026-03-10', 20000.00, 'Canceled'), 
(5, 5, '2026-04-01', 8000.00, 'Invoiced'), (6, 6, '2026-04-15', 15000.00, 'Active'), 
(7, 7, '2026-05-01', 3100.00, 'Invoiced'), (8, 8, '2026-05-10', 30000.00, 'Active'), 
(9, 9, '2026-06-01', 5200.00, 'Invoiced'), (10, 10, '2026-06-20', 6000.00, 'Active'), 
(11, 11, '2026-07-01', 7500.00, 'Invoiced'), (12, 12, '2026-07-15', 25000.00, 'Active'), 
(13, 13, '2026-08-01', 15000.00, 'Invoiced'), (14, 14, '2026-08-20', 9000.00, 'Active'), 
(15, 15, '2026-09-01', 4200.00, 'Invoiced'), (16, 16, '2026-09-15', 11000.00, 'Active'), 
(17, 17, '2026-10-01', 6100.00, 'Invoiced'), (18, 18, '2026-10-10', 45000.00, 'Active'), 
(19, 19, '2026-11-01', 3400.00, 'Invoiced'), (20, 20, '2026-11-20', 7500.00, 'Active'); 

-- Sasmit Tomar Inserts --
INSERT INTO invoice_line (Line_ID, Invoice_ID, Description, Quantity_or_Hours, Unit_Price, Line_Total) VALUES 
(1, 1, 'Monthly Social Media Mgmt', 30.00, 150.00, 4500.00), 
(2, 2, 'Branding Deliverable 1', 1.00, 12500.00, 12500.00), 
(3, 3, 'SEO Analysis - Tokyo', 20.00, 110.00, 2200.00), 
(4, 5, 'Strategic Consulting', 40.00, 200.00, 8000.00), 
(5, 6, 'Market Research BA', 1.00, 15000.00, 15000.00), 
(6, 7, 'PPC Ad Setup', 25.00, 124.00, 3100.00), 
(7, 8, 'Corporate Video Editing', 1.00, 30000.00, 30000.00), 
(8, 9, 'Email Campaign Execution', 35.00, 148.57, 5200.00), 
(9, 10, 'Milestone - Automation', 1.00, 6000.00, 6000.00), 
(10, 11, 'Influencer Management', 50.00, 150.00, 7500.00), 
(11, 12, 'E-commerce Dev Launch', 1.00, 25000.00, 25000.00), 
(12, 13, 'Network Architecture LA', 100.00, 150.00, 15000.00), 
(13, 14, 'Quarterly Review Pack', 1.00, 9000.00, 9000.00), 
(14, 15, 'UX Review Consulting', 28.00, 150.00, 4200.00), 
(15, 16, 'SEO Final Milestone', 1.00, 11000.00, 11000.00), 
(16, 17, 'Copywriting Services', 40.00, 152.50, 6100.00), 
(17, 18, 'Global App Integration', 1.00, 45000.00, 45000.00), 
(18, 19, 'Cloud Maintenance', 22.00, 154.55, 3400.00), 
(19, 20, 'Logo Design Final', 1.00, 7500.00, 7500.00), 
(20, 1, 'Overtime Consulting', 10.00, 225.00, 2250.00); 

-- Esrom Ghebrai Inserts --
INSERT INTO PROJECT_TEAMS (team_id, project_id, member_name, role_name, email, allocation_pct, joined_date) VALUES
(1, 1, 'Elena Brooks', 'Project Lead', 'elena.brooks@corp.example', 50.00, '2025-01-10'),
(2, 2, 'Marcus Young', 'UX Designer', 'marcus.young@corp.example', 35.00, '2025-02-01'),
(3, 3, 'Tanya Hughes', 'Data Analyst', 'tanya.hughes@corp.example', 40.00, '2025-01-20'),
(4, 4, 'Robert King', 'Security Architect', 'robert.king@corp.example', 45.00, '2025-03-01'),
(5, 5, 'Priya Desai', 'Mobile Developer', 'priya.desai@corp.example', 60.00, '2025-02-10'),
(6, 6, 'Lucas Bennett', 'HR Systems Analyst', 'lucas.bennett@corp.example', 55.00, '2025-01-15'),
(7, 7, 'Hannah Reed', 'Data Scientist', 'hannah.reed@corp.example', 50.00, '2025-03-05'),
(8, 8, 'Owen Parker', 'Cloud Engineer', 'owen.parker@corp.example', 40.00, '2025-02-20'),
(9, 9, 'Leah Foster', 'Compliance Analyst', 'leah.foster@corp.example', 30.00, '2025-01-25'),
(10, 10, 'Victor Gomez', 'Data Engineer', 'victor.gomez@corp.example', 50.00, '2025-03-10'),
(11, 11, 'Claire Evans', 'Operations Analyst', 'claire.evans@corp.example', 45.00, '2025-02-05'),
(12, 12, 'Adam Collins', 'Payroll Specialist', 'adam.collins@corp.example', 60.00, '2025-01-18'),
(13, 13, 'Jasmine Turner', 'Integration Engineer', 'jasmine.turner@corp.example', 50.00, '2025-03-01'),
(14, 14, 'Peter Morgan', 'API Developer', 'peter.morgan@corp.example', 35.00, '2025-02-12'),
(15, 15, 'Grace Hall', 'Search Engineer', 'grace.hall@corp.example', 55.00, '2025-01-22'),
(16, 16, 'Henry Scott', 'Reporting Analyst', 'henry.scott@corp.example', 45.00, '2025-03-15'),
(17, 17, 'Mia Carter', 'Infrastructure Engineer', 'mia.carter@corp.example', 40.00, '2025-02-25'),
(18, 18, 'Daniel Rivera', 'Records Manager', 'daniel.rivera@corp.example', 30.00, '2025-01-28'),
(19, 19, 'Chloe Phillips', 'Portal Developer', 'chloe.phillips@corp.example', 35.00, '2025-04-01'),
(20, 20, 'Eli Murphy', 'Sustainability Analyst', 'eli.murphy@corp.example', 50.00, '2025-03-20');

-- Esrom Ghebrai Inserts --
INSERT INTO PROJECT_MILESTONES (milestone_id, project_id, milestone_name, due_date, completion_date, status, deliverable) VALUES
(1, 1, 'Requirements Baseline Approved', '2025-02-15', '2025-02-14', 'Completed', 'Signed-off requirements document'),
(2, 2, 'UX Prototype Released', '2025-03-15', NULL, 'In Progress', 'Clickable prototype'),
(3, 3, 'Data Model Design Completed', '2025-02-28', '2025-03-01', 'Completed', 'Initial warehouse schema'),
(4, 4, 'Security Assessment Passed', '2025-04-15', NULL, 'In Progress', 'Security review report'),
(5, 5, 'App Store Launch', '2025-05-20', '2025-05-18', 'Completed', 'Production mobile app'),
(6, 6, 'Pilot Go-Live', '2025-03-20', '2025-03-19', 'Completed', 'HR portal pilot release'),
(7, 7, 'Model Validation', '2025-06-15', NULL, 'In Progress', 'Forecasting validation pack'),
(8, 8, 'Foundation Landing Zone Ready', '2025-04-30', NULL, 'Pending', 'Cloud foundation checklist'),
(9, 9, 'Policy Mapping Complete', '2025-03-10', '2025-03-09', 'Completed', 'Compliance mapping matrix'),
(10, 10, 'Catalog Rollout', '2025-05-30', NULL, 'In Progress', 'Data catalog rollout plan'),
(11, 11, 'Route Optimization Pilot', '2025-04-25', '2025-04-24', 'Completed', 'Optimized route schedules'),
(12, 12, 'Parallel Run Completed', '2025-03-28', '2025-03-27', 'Completed', 'Payroll reconciliation report'),
(13, 13, 'MVP Integration Complete', '2025-06-20', NULL, 'In Progress', 'CRM integration package'),
(14, 14, 'Architecture Review', '2025-03-30', NULL, 'Pending', 'API architecture approval notes'),
(15, 15, 'A/B Test Completed', '2025-04-18', '2025-04-17', 'Completed', 'Search test results'),
(16, 16, 'Submission Template Finalized', '2025-06-30', NULL, 'In Progress', 'Regulatory submission template'),
(17, 17, 'DR Drill Executed', '2025-03-22', '2025-03-21', 'Completed', 'Disaster recovery drill log'),
(18, 18, 'Retention Policy Applied', '2025-04-10', NULL, 'On Hold', 'Records retention policy update'),
(19, 19, 'Supplier Onboarding Beta', '2025-06-15', NULL, 'Pending', 'Vendor portal beta release'),
(20, 20, 'KPI Source Map Approved', '2025-05-05', NULL, 'In Progress', 'Sustainability source map');

-- Esrom Ghebrai Inserts --
INSERT INTO COMPLIANCE_ALERTS (alert_id, project_id, alert_date, alert_type, severity, description, resolved_status) VALUES
(1, 1, '2025-02-05', 'Interface Reconciliation Lag', 'Medium', 'Delayed synchronization between ERP and finance ledger', 'Resolved'),
(2, 2, '2025-02-14', 'Privacy Notice Review', 'Low', 'Legal review pending for portal cookie banner', 'Open'),
(3, 3, '2025-02-22', 'Stale Master Data', 'Medium', 'Warehouse dashboard references outdated item codes', 'Resolved'),
(4, 4, '2025-03-18', 'Firewall Rule Exception', 'High', 'Temporary firewall exception still awaiting sign-off', 'Open'),
(5, 5, '2025-04-02', 'Privacy Notice Update', 'Medium', 'Mobile app store listing needs updated privacy notice', 'Resolved'),
(6, 6, '2025-02-20', 'Access Review Evidence', 'High', 'HR portal access review evidence not uploaded', 'Resolved'),
(7, 7, '2025-03-29', 'Data Freshness Issue', 'Medium', 'Forecasting model uses last week''s inventory feed', 'Open'),
(8, 8, '2025-03-12', 'Tagging Policy Gap', 'Medium', 'Cloud resources missing mandatory environment tags', 'Open'),
(9, 9, '2025-02-28', 'Sanctions Screening Evidence', 'Critical', 'Supplier onboarding package missing sanctions record', 'Resolved'),
(10, 10, '2025-04-05', 'Data Retention Mapping', 'High', 'Data lake tables require retention classification', 'Open'),
(11, 11, '2025-03-07', 'Device Compliance Check', 'Medium', 'Field service tablets not fully enrolled in MDM', 'Resolved'),
(12, 12, '2025-02-24', 'Audit Trail Archive', 'High', 'Payroll audit trail archive pending retention approval', 'Resolved'),
(13, 13, '2025-04-11', 'API Key Rotation', 'High', 'Integration keys exceeded rotation policy window', 'Open'),
(14, 14, '2025-03-20', 'Security Review Gate', 'Medium', 'Gateway rate limit policy awaiting security approval', 'Open'),
(15, 15, '2025-04-10', 'Search Logs Privacy', 'High', 'Search logs retain personal data beyond policy', 'Resolved'),
(16, 16, '2025-04-18', 'Submission Naming', 'Critical', 'Regulatory report file names do not match template', 'Open'),
(17, 17, '2025-03-22', 'DR Evidence Timing', 'Medium', 'Recovery evidence uploaded after the drill deadline', 'Resolved'),
(18, 18, '2025-03-01', 'Archive Permissions', 'High', 'Document archive folder permissions exceed policy', 'Open'),
(19, 19, '2025-04-12', 'Vendor Tax Forms', 'High', 'Hotel vendor tax forms still incomplete', 'Open'),
(20, 20, '2025-04-22', 'Sensor Calibration', 'Medium', 'Sustainability metrics source missing calibration certificate', 'Open');

-- Esrom Ghebrai Inserts --
INSERT INTO PROJECT_KPIs (kpi_id, project_id, kpi_name, target_value, actual_value, measurement_unit, reporting_period, status) VALUES
(1, 1, 'Process Automation Coverage', 85.00, 88.00, '%', 'Q1 2025', 'Met'),
(2, 2, 'User Satisfaction', 90.00, 84.00, '%', 'Q1 2025', 'Below Target'),
(3, 3, 'Report Refresh Time', 10.00, 12.00, 'seconds', 'Q1 2025', 'Needs Improvement'),
(4, 4, 'Critical Findings Closed', 100.00, 95.00, '%', 'Q1 2025', 'On Track'),
(5, 5, 'Monthly Active Users', 500.00, 640.00, 'users', 'Q2 2025', 'Exceeded'),
(6, 6, 'Self-Service Adoption', 70.00, 76.00, '%', 'Q1 2025', 'Met'),
(7, 7, 'Forecast Accuracy', 92.00, 89.00, '%', 'Q2 2025', 'On Track'),
(8, 8, 'Workloads Migrated', 40.00, NULL, '%', 'Q1 2025', 'Not Started'),
(9, 9, 'Audit Pass Rate', 98.00, 100.00, '%', 'Q1 2025', 'Exceeded'),
(10, 10, 'Data Quality Score', 95.00, 91.00, '%', 'Q2 2025', 'On Track'),
(11, 11, 'First-Time Fix Rate', 80.00, 83.00, '%', 'Q1 2025', 'Met'),
(12, 12, 'Payroll Error Rate', 1.00, 0.50, '%', 'Q1 2025', 'Met'),
(13, 13, 'Lead Sync Latency', 2.00, 1.80, 'minutes', 'Q2 2025', 'Met'),
(14, 14, 'API Uptime', 99.90, NULL, '%', 'Q1 2025', 'Not Started'),
(15, 15, 'Search Relevance Score', 85.00, 87.00, '%', 'Q2 2025', 'Exceeded'),
(16, 16, 'Reports Submitted On Time', 100.00, 97.00, '%', 'Q2 2025', 'On Track'),
(17, 17, 'Recovery Time Objective', 60.00, 54.00, 'minutes', 'Q1 2025', 'Met'),
(18, 18, 'Duplicate Records Removed', 10000.00, 4200.00, 'records', 'Q1 2025', 'Behind Schedule'),
(19, 19, 'Vendor Onboarding Completion', 75.00, NULL, '%', 'Q2 2025', 'Not Started'),
(20, 20, 'Emission Metrics Coverage', 90.00, 62.00, '%', 'Q2 2025', 'In Progress');

-- Esrom Ghebrai Inserts --
INSERT INTO PROJECT_ALLOCATION (allocation_id, project_id, team_id, resource_type, allocated_hours, allocation_start, allocation_end, allocation_status) VALUES
(1, 1, 1, 'ERP Functional Team', 180, '2025-01-10', '2025-05-30', 'Closed'),
(2, 2, 2, 'UX and Front-End Team', 160, '2025-02-01', '2025-07-15', 'Active'),
(3, 3, 3, 'BI Team', 140, '2025-01-20', '2025-06-20', 'Paused'),
(4, 4, 4, 'Security Team', 220, '2025-03-01', '2025-08-01', 'Active'),
(5, 5, 5, 'Mobile Dev Team', 200, '2025-02-10', '2025-06-10', 'Closed'),
(6, 6, 6, 'HRIS Team', 120, '2025-01-15', '2025-04-30', 'Closed'),
(7, 7, 7, 'Data Science Team', 240, '2025-03-05', '2025-09-30', 'Active'),
(8, 8, 8, 'Cloud Platform Team', 320, '2025-02-20', '2025-11-15', 'Planned'),
(9, 9, 9, 'Compliance Ops Team', 150, '2025-01-25', '2025-05-25', 'Closed'),
(10, 10, 10, 'Data Governance Team', 210, '2025-03-10', '2025-10-10', 'Active'),
(11, 11, 11, 'Field Ops Team', 170, '2025-02-05', '2025-07-05', 'Closed'),
(12, 12, 12, 'Payroll Team', 100, '2025-01-18', '2025-04-18', 'Closed'),
(13, 13, 13, 'Integration Team', 190, '2025-03-01', '2025-08-30', 'Active'),
(14, 14, 14, 'API Platform Team', 230, '2025-02-12', '2025-09-12', 'Planned'),
(15, 15, 15, 'Search and Catalog Team', 160, '2025-01-22', '2025-06-22', 'Closed'),
(16, 16, 16, 'Reporting Team', 260, '2025-03-15', '2025-12-15', 'Active'),
(17, 17, 17, 'Infrastructure Team', 90, '2025-02-25', '2025-05-25', 'Closed'),
(18, 18, 18, 'Records Management Team', 110, '2025-01-28', '2025-05-28', 'On Hold'),
(19, 19, 19, 'Portal Team', 150, '2025-04-01', '2025-09-01', 'Planned'),
(20, 20, 20, 'Sustainability Analytics Team', 175, '2025-03-20', '2025-10-20', 'Active');

COMMIT;

/* Stored Procedures */
-- Tyson Shannon Stored Procedure --
DELIMITER $$
CREATE PROCEDURE Optimize_Labor_Compliance()
BEGIN
    -- fix incorrect overtime flags
    UPDATE Work_Schedule ws
    JOIN Location l ON ws.Location_ID = l.Location_ID
    JOIN Country c ON l.Country_ID = c.Country_ID
    JOIN Labor_Policies lp ON c.Country_ID = lp.Country_ID
    SET ws.Is_OT = 
        CASE 
            WHEN ws.Total_Hours > lp.Max_Regular_Daily_Hrs THEN 1
            ELSE 0
        END;
    -- display the fixed table
    SELECT 
        ws.Schedule_ID,
        ws.Employee_ID,
        ws.Total_Hours,
        ws.Is_OT AS Updated_OT_Flag
    FROM Work_Schedule ws;

    -- shows shifts violating daily limits
    SELECT 
        c.Country_Name,
        ws.Employee_ID,
        ws.Total_Hours,
        lp.Max_Daily_Hrs,
        CASE 
            WHEN ws.Total_Hours > lp.Max_Daily_Hrs THEN 'VIOLATION'
            ELSE 'OK'
        END AS Daily_Compliance_Status
    FROM Work_Schedule ws
    JOIN Location l ON ws.Location_ID = l.Location_ID
    JOIN Country c ON l.Country_ID = c.Country_ID
    JOIN Labor_Policies lp ON c.Country_ID = lp.Country_ID;

    -- country level workload and ot usage
    SELECT 
        c.Country_Name,
        COUNT(ws.Schedule_ID) AS Total_Shifts,
        SUM(ws.Total_Hours) AS Total_Hours,
        SUM(ws.Is_OT) AS OT_Shifts,
        ROUND(SUM(ws.Is_OT) / COUNT(ws.Schedule_ID) * 100, 2) AS OT_Percentage
    FROM Country c
    LEFT JOIN Location l ON c.Country_ID = l.Country_ID
    LEFT JOIN Work_Schedule ws ON l.Location_ID = ws.Location_ID
    GROUP BY c.Country_Name
    ORDER BY OT_Percentage DESC;
END$$
DELIMITER ;

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

-- Joseph Mueller Stored Procedure --
DELIMITER $$
CREATE PROCEDURE GetTimecardDetail(IN p_timecard_id INT)
BEGIN
    SELECT
        t.Timecard_ID,
        UPPER(t.Status)                                        AS Status,
        DATEDIFF(t.Pay_Period_End, t.Pay_Period_Start) + 1     AS Period_Days,
        tc.Category_Name,
        tc.Is_Billable,
        ROUND(te.Hours_Accrued, 2)                             AS Hours_Accrued,
        te.Entry_Date
    FROM Timecard t
        JOIN Timecard_Entries te ON t.Timecard_ID = te.Timecard_ID
        JOIN Task_Category    tc ON te.Task_ID = tc.Task_ID
    WHERE t.Timecard_ID = p_timecard_id
    ORDER BY te.Entry_Date;
END$$
DELIMITER ;

-- Creston Dorothy Stored Procedure --
DELIMITER $$

CREATE PROCEDURE onboard_client_organization (
  IN p_entity_id INT,
  IN p_org_id INT,
  IN p_org_name VARCHAR(70),
  IN p_alias_id INT,
  IN p_alias_name VARCHAR(70),
  IN p_contact_id INT,
  IN p_contact_first_name VARCHAR(50),
  IN p_contact_last_name VARCHAR(50),
  IN p_contact_email VARCHAR(100),
  IN p_parent_org_id INT,
  OUT p_status_code INT,
  OUT p_status_message VARCHAR(255)
)
main_block: BEGIN
  DECLARE v_count INT DEFAULT 0;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SET p_status_code = -1;
    SET p_status_message = 'SQL exception occured, rolled back the transaction.';
  END;

  START TRANSACTION;

  SELECT COUNT(*)
  INTO v_count
  FROM ENTITY
  WHERE Entity_ID = p_entity_id;

  IF v_count > 0 THEN
    ROLLBACK;
    SET p_status_code = 10;
    SET p_status_message = 'Entity already exists';
    LEAVE main_block;
  END IF;

  SELECT COUNT(*)
  INTO v_count
  FROM organizations
  WHERE Org_Name = p_org_name;

  IF v_count > 0 THEN
    ROLLBACK;
    SET p_status_code = 20;
    SET p_status_message = 'Organization name already exists.';
    LEAVE main_block;
  END IF;

  SELECT COUNT(*)
  INTO v_count
  FROM org_alias
  WHERE Alias_ID = p_alias_id;

  IF v_count > 0 THEN
    ROLLBACK;
    SET p_status_code = 30;
    SET p_status_message = 'Alias_ID already exists.';
    LEAVE main_block;
  END IF;

  SELECT COUNT(*)
  INTO v_count
  FROM client_contacts
  WHERE Contact_ID = p_contact_id;

  IF v_count > 0 THEN
    ROLLBACK;
    SET p_status_code = 50;
    SET p_status_message = 'Contact_ID already exists.';
    LEAVE main_block;
  END IF;

  SELECT COUNT(*)
  INTO v_count
  FROM client_org_structure
  WHERE Org_ID = p_org_id;

  IF v_count > 0 THEN
    ROLLBACK;
    SET p_status_code = 60;
    SET p_status_message = 'Org_ID already exists.';
    LEAVE main_block;
  END IF;

  IF p_parent_org_id IS NOT NULL THEN
    SELECT COUNT(*)
    INTO v_count
    FROM client_org_structure
    WHERE Org_ID = p_parent_org_id;

    IF v_count = 0 THEN
      ROLLBACK;
      SET p_status_code = 70;
      SET p_status_message = 'Parent Organization does not exist';
      LEAVE main_block;
    END IF;
  END IF;

  INSERT INTO ENTITY (Entity_ID, Entity_Type)
  VALUES (p_entity_id, 'Organization');

  INSERT INTO organizations (Entity_ID, Org_Name)
  VALUES (p_entity_id, p_org_name);

  INSERT INTO org_alias (Alias_ID, Entity_ID, Alias_Name)
  VALUES (p_alias_id, p_entity_id, p_alias_name);

  INSERT INTO client_contacts (
    Contact_ID,
    Client_ID,
    First_Name,
    Last_Name,
    Email
  )
  VALUES (
    p_contact_id,
    p_entity_id,
    p_contact_first_name,
    p_contact_last_name,
    p_contact_email
  );

  INSERT INTO client_org_structure (
    Org_ID,
    Entity_ID,
    Parent_Org_ID
  )
  VALUES (
    p_org_id,
    p_entity_id,
    p_parent_org_id
  );

  COMMIT;

  SET p_status_code = 0;
  SET p_status_message = 'Client organization created successfully.';
END main_block$$

DELIMITER ;

-- Elizabeth Luttmann Stored Procedure --
DELIMITER //

CREATE PROCEDURE SP_NEW_HIRE(
IN var_FirstName VARCHAR(30),
IN var_LastName VARCHAR(30),
IN var_Salary DECIMAL(15,2),
IN var_Address_Line1 VARCHAR(50),
IN var_City VARCHAR(50),
IN var_State_Province VARCHAR(50),
IN var_Postal_Code VARCHAR(10),
IN var_Country_Code VARCHAR(50),
IN var_Hire_Date DATE,
IN var_PhoneNumber VARCHAR(15)
)
BEGIN

    DECLARE var_Email VARCHAR(50);
    DECLARE var_Entity_ID INT;
    DECLARE var_Employment_Status VARCHAR(50);
    DECLARE var_Address_ID INT;
    DECLARE var_Phone_Number_ID INT;

    SET var_Email = CONCAT(var_FirstName, '.', var_LastName, '@zeroindex.com');
    SET var_Employment_Status = 'New';
    SET var_Address_ID = (
		SELECT IFNULL(MAX(Address_ID), 0) + 1
		FROM ADDRESS);
	SET var_Phone_Number_ID = (
		select IFNULL(MAX(Phone_Number_ID), 0) + 1
        FROM phone_number);

    START TRANSACTION;

    -- 1. CREATE ENTITY FIRST
    INSERT INTO ENTITY (Entity_Type)
    VALUES ('Employee');

    SET var_Entity_ID = LAST_INSERT_ID();

    -- 2. EMPLOYEE
    INSERT INTO EMPLOYEE (
        Entity_ID,
        FirstName,
        LastName,
        Email,
        Hire_Date,
        Employment_Status,
        Salary
    )
    VALUES (
        var_Entity_ID,
        var_FirstName,
        var_LastName,
        var_Email,
        var_Hire_Date,
        var_Employment_Status,
        var_Salary
    );

    -- 3. ADDRESS
    INSERT INTO ADDRESS (
        Address_ID,
        Entity_ID,
        Address_Line1,
        City,
        State_Province,
        Postal_Code,
        Country_Code
    )
    VALUES (
        var_Address_ID,
        var_Entity_ID,
        var_Address_Line1,
        var_City,
        var_State_Province,
        var_Postal_Code,
        var_Country_Code
    );

    -- 4. PHONE
    INSERT INTO PHONE_NUMBER (
        Phone_Number_ID,
        Entity_ID,
        PhoneNumber
    )
    VALUES (
        var_Phone_Number_ID,
        var_Entity_ID,
        var_PhoneNumber
    );

    COMMIT;

END //

DELIMITER ;

-- Esrom Ghebrai Stored Procedure --
DELIMITER $$

CREATE PROCEDURE Project_Health_Audit()
BEGIN

    -- FUNCTION 1: Fix milestones completed but not marked
    UPDATE PROJECT_MILESTONES
    SET status = 'Completed'
    WHERE completion_date IS NOT NULL
      AND status <> 'Completed';

    -- FUNCTION 2: Show all overdue milestones
    SELECT 
        p.project_code,
        p.project_name,
        p.project_manager,
        m.milestone_name,
        m.due_date,
        DATEDIFF(CURDATE(), m.due_date) AS days_overdue,
        m.status
    FROM PROJECT_MILESTONES m
    JOIN PROJECTS p ON m.project_id = p.project_id
    WHERE m.completion_date IS NULL
      AND m.due_date < CURDATE()
    ORDER BY days_overdue DESC;

    -- FUNCTION 3: Project health scorecard
    SELECT 
        p.project_code,
        p.project_name,
        p.project_manager,
        p.status AS project_status,
        COUNT(ca.alert_id) AS open_alerts,
        SUM(CASE WHEN k.actual_value < k.target_value THEN 1 ELSE 0 END) AS kpis_below_target
    FROM PROJECTS p
    LEFT JOIN COMPLIANCE_ALERTS ca 
           ON p.project_id = ca.project_id 
          AND ca.resolved_status = 'Open'
    LEFT JOIN PROJECT_KPIs k 
           ON p.project_id = k.project_id
    GROUP BY p.project_id, p.project_code, p.project_name, 
             p.project_manager, p.status
    ORDER BY open_alerts DESC;

END$$

DELIMITER ;

COMMIT;

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

-- Tyson Shannon Report --
SELECT 
    Country.Country_Name,
    COUNT(DISTINCT Work_Schedule.Employee_ID) AS Total_Employees,
    SUM(Work_Schedule.Total_Hours) AS Total_Hours_Worked,
    SUM(CASE WHEN Work_Schedule.Is_OT = 1 THEN Work_Schedule.Total_Hours ELSE 0 END) AS Overtime_Hours,
    ROUND(
        SUM(CASE WHEN Work_Schedule.Is_OT = 1 THEN Work_Schedule.Total_Hours ELSE 0 END)
        / NULLIF(SUM(Work_Schedule.Total_Hours),0) * 100, 2
    ) AS Overtime_Percentage
FROM Work_Schedule
JOIN Location ON Work_Schedule.Location_ID = Location.Location_ID
JOIN Country ON Location.Country_ID = Country.Country_ID
GROUP BY Country.Country_Name
ORDER BY Overtime_Percentage DESC;

-- Tyson Shannon Report --
SELECT 
    Country.Country_Name,
    Work_Schedule.Employee_ID,
    SUM(Work_Schedule.Total_Hours) AS Total_Hours_Worked,
    Labor_Policies.Max_Weekly_Hrs,
    CASE 
        WHEN SUM(Work_Schedule.Total_Hours) > Labor_Policies.Max_Weekly_Hrs THEN 'VIOLATION'
        ELSE 'COMPLIANT'
    END AS Compliance_Status
FROM Work_Schedule
JOIN Location ON Work_Schedule.Location_ID = Location.Location_ID
JOIN Country ON Location.Country_ID = Country.Country_ID
JOIN Labor_Policies ON Country.Country_ID = Labor_Policies.Country_ID
GROUP BY Country.Country_Name, Work_Schedule.Employee_ID, Labor_Policies.Max_Weekly_Hrs
ORDER BY Compliance_Status DESC, Total_Hours_Worked DESC;

-- Tyson Shannon Report --
SELECT 
    Location.Location_Name,
    Country.Country_Name,
    COUNT(Work_Schedule.Schedule_ID) AS Total_Shifts,
    SUM(Work_Schedule.Total_Hours) AS Total_Hours,
    AVG(Work_Schedule.Total_Hours) AS Avg_Hours_Per_Shift,
    SUM(Work_Schedule.Is_OT) AS OT_Shifts,
    ROUND(
        SUM(Work_Schedule.Is_OT)
        / COUNT(Work_Schedule.Schedule_ID) * 100, 2
    ) AS OT_Shift_Percentage
FROM Work_Schedule
JOIN Location ON Work_Schedule.Location_ID = Location.Location_ID
JOIN Country ON Location.Country_ID = Country.Country_ID
GROUP BY Location.Location_Name, Country.Country_Name
ORDER BY Total_Hours DESC;

-- Tyson Shannon Report --
SELECT 
    Country.Country_Name,
    Labor_Policies.Max_Weekly_Hrs,
    Labor_Policies.Max_Daily_Hrs,
    Labor_Policies.OT_Rate_Multiplier
FROM Country
JOIN Labor_Policies ON Country.Country_ID = Labor_Policies.Country_ID
LEFT JOIN Location ON Country.Country_ID = Location.Country_ID
LEFT JOIN Work_Schedule ON Location.Location_ID = Work_Schedule.Location_ID
GROUP BY Country.Country_Name, Labor_Policies.Max_Weekly_Hrs, Labor_Policies.Max_Daily_Hrs, Labor_Policies.OT_Rate_Multiplier
ORDER BY Labor_Policies.Max_Weekly_Hrs;

-- Creston Dorothy Report Inventory value by Country--
SELECT 
 c.Country_Name,
    COUNT(i.Product_ID) AS Product_Count,
    SUM(i.QOH) AS Total_Units_On_Hand,
    ROUND(SUM(i.QOH * p.Product_Cost), 2) AS Total_Inventory_Value,
    ROUND(AVG(i.QOH), 2) AS Avg_QOH_Per_Product
FROM inventory i
JOIN product p
 ON i.Product_ID = p.Product_ID
JOIN Country c
 ON i.Country_ID = c.Country_ID
GROUP BY c.Country_Name
ORDER BY Total_Inventory_Value DESC, Total_Units_On_Hand DESC;

-- Creston Dorothy Report Stock for reorders (product stock  info)--
SELECT
    c.Country_Name,
    p.Product_Name,
    i.QOH,
    p.Product_Cost,
    ROUND(i.QOH * p.Product_Cost, 2) AS Inventory_Value,
    CASE
        WHEN i.QOH <= 8 THEN 'Critical'
        WHEN i.QOH <= 15 THEN 'Low'
        ELSE 'Sufficient'
    END AS Stock_Status
FROM inventory i
JOIN product p
    ON i.Product_ID = p.Product_ID
JOIN Country c
    ON i.Country_ID = c.Country_ID
ORDER BY i.QOH ASC, Inventory_Value DESC;
 
-- Creston Dorothy Product Coverage report --
SELECT
    p.Product_Name,
    COUNT(DISTINCT i.Country_ID) AS Countries_Available_In,
    SUM(i.QOH) AS Total_Units_Distributed,
    ROUND(AVG(i.QOH), 2) AS Avg_Units_Per_Country,
    ROUND(SUM(i.QOH * p.Product_Cost), 2) AS Total_Product_Value
FROM product p
JOIN inventory i
    ON p.Product_ID = i.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Countries_Available_In DESC, Total_Product_Value DESC;
 
-- Elizabeth Luttmann Report --
SELECT address.country_code AS Country, ROUND(AVG(employee.Salary),2) AS Average_Salary
FROM entity
INNER JOIN address ON entity.entity_id = address.Entity_ID
INNER JOIN employee ON entity.entity_id = employee.entity_id
GROUP BY address.country_code;

-- Elizabeth Luttmann Report --
SELECT DEPARTMENT_NAME,Location_time_zone,count(*)
FROM department 
INNER JOIN employee ON department.department_id=employee.Department_ID
INNER JOIN location ON location.location_Id = employee.location_id
GROUP BY department_name, location_time_zone
ORDER BY department_name;

-- Elizabeth Luttmann Report --
SELECT ROUND(AVG(DATEDIFF(END_DATE, START_DATE)),0) AS Average_Days_Employed, LOCATION_NAME
FROM employee_history
INNER JOIN location ON employee_history.Location_ID = LOCATION.LOCATION_ID
GROUP BY LOCATION_NAME
ORDER BY 1 DESC;

-- Esrom Ghebrai Report --
SELECT 
    department,
    COUNT(*) AS total_projects,
    SUM(budget) AS total_budget
FROM PROJECTS
GROUP BY department
ORDER BY total_budget DESC;

-- Esrom Ghebrai Report --
SELECT 
    p.project_manager,
    COUNT(ca.alert_id) AS open_alerts
FROM PROJECTS p
INNER JOIN COMPLIANCE_ALERTS ca ON p.project_id = ca.project_id
WHERE ca.resolved_status = 'Open'
GROUP BY p.project_manager
ORDER BY open_alerts DESC;

-- Esrom Ghebrai Report --
SELECT 
    p.project_code,
    p.project_name,
    k.kpi_name,
    k.target_value,
    k.actual_value,
    k.status
FROM PROJECTS p
INNER JOIN PROJECT_KPIs k ON p.project_id = k.project_id
WHERE k.actual_value < k.target_value
ORDER BY p.project_code;

-- Joseph Mueller Report --
CREATE INDEX idx_te_task_id ON Timecard_Entries(Task_ID);

SELECT 
    tc.Category_Name,
    tc.Is_Billable,
    COUNT(te.Entry_ID) AS Total_Entries,
    SUM(te.Hours_Accrued) AS Total_Hours_Accrued
FROM Timecard_Entries te FORCE INDEX(idx_te_task_id)
JOIN Task_Category tc ON te.Task_ID = tc.Task_ID
GROUP BY tc.Task_ID, tc.Category_Name, tc.Is_Billable
ORDER BY Total_Hours_Accrued DESC;

-- Joseph Mueller Report --
CREATE INDEX idx_usr_role_status ON Users(User_Role_ID, Account_Status);

SELECT 
    ur.Role_Name,
    ur.Permission_Level,
    u.Account_Status,
    COUNT(u.User_ID) AS Total_Users
FROM Users u
JOIN User_Roles ur ON u.User_Role_ID = ur.User_Role_ID
GROUP BY ur.Role_Name, ur.Permission_Level, u.Account_Status
ORDER BY ur.Permission_Level DESC, u.Account_Status;

-- Joseph Mueller Report --
CREATE INDEX idx_te_project_timecard ON Timecard_Entries(Project_ID, Timecard_ID);
CREATE INDEX idx_ot_timecard ON Overtime_Logs(Timecard_ID);

SELECT 
    te.Project_ID,
    COUNT(DISTINCT t.Timecard_ID)    AS Total_Timecards,
    SUM(t.Hours_Worked)              AS Total_Hours_Worked,
    COALESCE(SUM(ol.OT_Hours), 0)    AS Total_OT_Hours,
    SUM(t.Hours_Worked) + COALESCE(SUM(ol.OT_Hours), 0) AS Total_Combined_Hours,
    t.Status
FROM Timecard t
JOIN Timecard_Entries te ON t.Timecard_ID = te.Timecard_ID
LEFT JOIN Overtime_Logs ol ON t.Timecard_ID = ol.Timecard_ID
WHERE te.Project_ID IS NOT NULL
GROUP BY te.Project_ID, t.Status
ORDER BY Total_Combined_Hours DESC;
