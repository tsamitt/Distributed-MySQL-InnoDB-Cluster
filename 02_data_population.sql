-- Sasmit Tomar Inserts --
INSERT INTO rate_cards (Rate_ID, Location_ID, Role_ID, Hourly_Rate, Currency_Code) VALUES 
(1, 1, 1, 150.00, 'USD'), (2, 1, 2, 85.00, 'USD'), (3, 1, 3, 95.00, 'USD'), (4, 1, 4, 70.00, 'USD'), 
(5, 2, 1, 22500.00, 'JPY'), (6, 2, 2, 12000.00, 'JPY'), (7, 2, 3, 14500.00, 'JPY'), (8, 2, 4, 9000.00, 'JPY'), 
(9, 3, 1, 18000.00, 'ARS'), (10, 3, 2, 9500.00, 'ARS'), (11, 3, 3, 11000.00, 'ARS'), (12, 3, 4, 7500.00, 'ARS'), 
(13, 1, 5, 200.00, 'USD'), (14, 2, 5, 30000.00, 'JPY'), (15, 3, 5, 25000.00, 'ARS'), (16, 1, 1, 155.00, 'USD'), 
(17, 2, 2, 12500.00, 'JPY'), (18, 3, 3, 11500.00, 'ARS'), (19, 1, 4, 72.00, 'USD'), (20, 2, 5, 31000.00, 'JPY'); 

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

