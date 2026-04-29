# Distributed-MySQL-InnoDB-Cluster

## Project Overview
This project involves the design and implementation of a high-availability distributed database system for a global digital marketing firm. The architecture is optimized for ACID compliance, scalability, and 3rd Normal Form (3NF) standards to handle complex global billing and contract management.

## Technical Stack
* **DBMS:** MySQL 8.4 with InnoDB Cluster
* **Operating System:** Ubuntu 24.04.4 LTS Server
* **Virtualization:** Oracle VirtualBox (3 Nodes in Host-Only mode)
* **Cluster Topology:** Single-Primary mode (1 Primary + 2 Secondary nodes)

## Key Contributions (Sasmit Tomar)

### 1. Relational Schema Design (3NF)
Designed and implemented 3NF compliant tables to manage global revenue cycles:
* **Contracts & Terms:** Handles both Hourly and Fixed pricing models.
* **Billing Infrastructure:** Dedicated tables for Invoices, Invoice Lines, and regional Rate Cards.

### 2. Automation: Stored Procedure `sp_CreateContractInvoice`
Developed an automation engine that handles the unified billing cycle:
* **Validation:** Automatically verifies contract activity dates before processing.
* **Constraint Enforcement:** Enforces a "Safety Valve" that blocks transactions if billed hours exceed the client's agreed Max Labor Hours.
* **Atomic Consistency:** Simultaneously updates invoice headers and itemized line items to maintain data parity.

### 3. Managerial Insights: SQL Reports
Created high-level reports to assist global management decision-making:
* **Budget Utilization Report:** Tracks digital marketing ROI by comparing investments vs. actual billing.
* **Global Labor Revenue Report:** Aggregates regional revenue across US, Japan, and Argentina in local currencies.
* **Contract Compliance Report:** Audit tool that flags over-billing violations in real-time.

### 4. Performance Optimization
* Utilized **Explain Plans** to verify efficient index usage (Primary and Foreign Keys).
* Implemented **COALESCE** and **JOIN** logic to ensure accurate data retrieval across distributed nodes.

## How to Run
1. Ensure a MySQL 8.4 instance or InnoDB Cluster is active.
2. Execute `sql/01_schema_ddl.sql` to build the structure.
3. Execute `sql/02_data_population.sql` to load the 3NF data.
4. Call the stored procedures or run reports as needed using `sql/03_stored_procedures.sql`.
