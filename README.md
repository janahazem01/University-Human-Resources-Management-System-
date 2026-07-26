# University HR Management System

A full-stack Human Resources management system built as a semester-long database project for the **Databases I** course (Winter 2025) at the German University in Cairo. The project models, implements, and exposes — through a web UI — the complete HR lifecycle of a university: employee records, departmental hierarchy, attendance, payroll, deductions, leave requests/approvals, and performance evaluations.

The project was delivered in three milestones, each building on the last:

1. **Conceptual & Logical Design** — EERD and relational schema
2. **Physical Implementation** — SQL Server database with stored procedures, functions, and views
3. **Application Layer** — a web application (ASP.NET or equivalent) connected to the database

### Core Domains

- **Employees** — personal info, contract type, salary, leave balances, replacements
- **Departments & Roles** — hierarchy, ranks, salary/overtime factors
- **Documents** — contracts, medical reports, national IDs, with expiry tracking
- **Attendance** — daily check-in/check-out logs, retained even after resignation
- **Payroll** — monthly salary records with bonuses and deductions
- **Deductions** — unpaid leave, missing hours/days, tied to payroll periods
- **Leave Management** — annual, accidental, medical (sick/maternity), unpaid, and compensation leave, each with its own multi-level approval hierarchy
- **Performance Evaluations** — semesterly ratings and reviews


### Project Breakdown

-**Milestone 1: Conceptual & Logical Design**-

- Designed the Enhanced Entity-Relationship Diagram (EERD)

- Translated the conceptual model into a relational schema

- Established entities, relationships, primary and foreign keys, and integrity constraints

-**Milestone 2: Backend & SQL Development**-

- Implemented the backend layer to handle database communication

- Developed SQL queries for Create, Read, Update, and Delete (CRUD) operations

- Applied validation mechanisms to preserve data consistency

-**Milestone 3: GUI Development**-

- Built role-based graphical interfaces, including:

- HR Login

- HR Employee Portal

- Dean / Vice-Dean / President Login

- Academic Employee Portal



