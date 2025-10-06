# JudicialDB

**JudicialDB** is a relational database implementation for a judicial/court management system.  
This repository contains the SQL scripts to create schemas, tables, functions, stored procedures, views, and triggers, a short PDF documentation (in Persian) explaining each table and routine, and an Entity-Relationship (ER) diagram.

---

## Project overview
This project models a court-information system that handles cases, sessions, judges, lawyers, defendants/parties, documents, judgments, appeals, and case history. The database is organized into three main schemas:

- `People` — people-related entities (Person, Judge, Lawyer, Defendant, Users, etc.).  
- `CourtManagement` — court operations (Court, Session, etc.).  
- `Cases` — case records and related entities (Case, Party, LawyerAssignment, Judgment, Document, Appeal, CaseHistory, etc.).

This system provides centralized management of people and organizational entities involved in judicial processes. The `People` schema stores profiles for judges, lawyers, defendants, plaintiffs, and system users, and supports role-based relationships (for example, one person can act as both a lawyer and a system user). Constraints and keys are defined to preserve data integrity, and the `People.Users` table is prepared for integration with an authentication layer in an application stack.

The Cases and CourtManagement schemas cover the full lifecycle of a case: case registration, lawyer assignments, scheduling court sessions, recording judgments, and tracking post-judgment workflows such as appeals. Stored procedures and triggers automate important business rules — for example, preventing overlapping sessions, automatically recording changes in `CaseHistory`, and validating appeal deadlines — which helps ensure procedural consistency and reduce manual errors.

For reporting and monitoring, the database includes views and helper functions that deliver practical operational outputs: lists of upcoming sessions, case-status summaries by type or court, and schedules for judges and lawyers. The schema separation (People, CourtManagement, Cases) enables clearer security boundaries, easier indexing and performance tuning, and straightforward extension into a web application or reporting service.

**For a fuller list of features and detailed descriptions of each table, function, stored procedure, and trigger, please review the `judicial_db_documentation.pdf` included in this repository.**

---

## Files in this repository
- `Create_Tabels.sql` — SQL script to create schemas and tables.
- `Create_Function.sql` — SQL script to create functions.   
- `Create_Procedure.sql` — SQL script to create stored procedures.
- `Create_Triggers.sql` — SQL script to create triggers.
- `Create_Views.sql` — SQL script to create views.
- `Insert_Data.sql` — SQL script to add data to tables.
- `judicial_db_documentation.pdf` — Short documentation (in Persian) describing each table, function, stored procedure, view and trigger, and referencing the ER diagram.  
- `Entity Relationship Diagram.jpg` — ER diagram image showing tables and relationships.
- `JudicalDB.bak` — A backup copy of the database.

---

## Key design notes
- Three separate schemas (`People`, `CourtManagement`, `Cases`) to separate concerns and security boundaries.  
- Important entities: `Person`, `Judge`, `Lawyer`, `Defendant`, `Court`, `Session`, `Case`, `Party`, `LawyerAssignment`, `Judgment`, `Document`, `Appeal`, `CaseHistory`.  
- Helper functions to fetch schedules, case history, and case status.  
- Views for quick reporting: upcoming sessions, active cases summary, judge schedules, lawyer schedules, court statistics.  
- Triggers to automatically record case history, prevent overlapping sessions, validate appeal deadlines, and enforce other business rules.

---

## Prerequisites
- Microsoft SQL Server (T-SQL). The script is written for a commonly available T-SQL dialect.  
- SQL Server Management Studio (SSMS) or another SQL client that can execute T-SQL scripts.  
- (Optional) `sqlcmd` or similar command-line tools for scripted deployments.

---


## Notes and limitations
- The included PDF (`judicial_db_documentation.pdf`) contains detailed descriptions of each table's fields, constraints, and the purpose of each function/procedure/trigger. Please refer to it for complete explanations.  
- The `People.Users` table is defined to support user accounts but the current project scope does not implement a full application layer; this table is prepared for future integration.  
- Because there are multiple triggers enforcing business rules (e.g., preventing overlapping sessions or preventing deletion of active records), loading large amounts of test data may require ordering inserts to respect foreign keys and triggers.

---

