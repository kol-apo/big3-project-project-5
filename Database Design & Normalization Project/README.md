# Big3 Construction Database - 5NF Normalization Project

## Overview
This project transforms Big3 Construction Company's messy spreadsheet data into a fully normalized MySQL database (5th Normal Form).

## Files Included
### SQL Files
- **01_create_tables.sql** – DDL statements to create all 14 normalized tables
- **02_insert_data.sql** – DML statements to populate all tables with data
- **03_verification_queries.sql** – Queries to verify data and demonstrate normalization benefits

### Documentation
- **normalization_documentation.md** – Detailed explanation of normalization process (1NF through 5NF)

## How to Run
### Option 1: Command Line
```bash
# Login to MySQL
mysql -u <username> -p

# Run the scripts in order
source 01_create_tables.sql
source 02_insert_data.sql
source 03_verification_queries.sql
```

### Option 2: MySQL Workbench
1. Open MySQL Workbench
2. Connect to your database server
3. Open and execute 01_create_tables.sql
4. Open and execute 02_insert_data.sql
5. Open and execute 03_verification_queries.sql

## Database Schema (5NF)
### Base Entity Tables (8 tables)
- **clients** – Company clients
- **supervisors** – Project supervisors
- **workers** – Construction workers
- **skills** – Worker skills lookup
- **certifications** – Worker certifications lookup
- **suppliers** – Material suppliers
- **materials** – Materials lookup
- **equipment** – Equipment lookup

### Central Entity Table (1 table)
- **projects** – Construction projects (links to clients)

### Junction Tables (5 tables)
- **worker_skills** – Many-to-many: workers ↔ skills
- **worker_certifications** – Many-to-many: workers ↔ certifications
- **supplier_phones** – Multi-valued attribute for suppliers
- **project_workers** – Many-to-many: projects ↔ workers (with supervisor)
- **project_supplier_materials** – Many-to-many: projects ↔ suppliers ↔ materials (with unit cost)
- **project_equipment** – Many-to-many: projects ↔ equipment (with rental cost)

## Key Features
### Constraints Implemented
- Primary keys on all tables
- Foreign key relationships with proper referential integrity
- CHECK constraints for phone formats (XXX-XXX-XXXX)
- CHECK constraints for positive values (rates, costs)
- CHECK constraints for email format validation
- UNIQUE constraints on names where appropriate

### Data Integrity
- Parent tables populated before child tables
- Referential integrity maintained throughout
- No data loss from original spreadsheet
- All multi-valued attributes properly separated

## Normalization Summary
| Normal Form | Issues Resolved |
|-------------|----------------|
| 1NF         | Eliminated repeating groups, separated multi-valued attributes |
| 2NF         | Removed partial dependencies (all tables have single-column PKs) |
| 3NF         | Removed transitive dependencies (separated lookup tables) |
| BCNF        | Ensured every determinant is a candidate key |
| 4NF         | Eliminated multi-valued dependencies (separated skills, certs, phones) |
| 5NF         | Eliminated join dependencies (proper junction tables) |

## Verification
Run the verification queries to confirm:
- All 7 projects are stored
- All 4 clients are stored
- All 5 workers are stored with their skills and certifications
- All relationships are properly maintained
- No data redundancy exists

## Notes
- Project IDs (P001, P002, etc.) are preserved as specified
- All phone numbers maintain XXX-XXX-XXXX format
- Dates are stored in YYYY-MM-DD format
- Monetary values use DECIMAL(10,2) for precision

## Created by 
- Mugemanyi Manzi David
- Olubanjo Kolapo Emmanuel
- Paul Rwagasana 
- John Obule