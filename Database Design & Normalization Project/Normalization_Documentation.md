Big3 Construction Database Normalization Documentation

## Executive Summary
This document explains the full normalization process for Big3 Construction Company’s project tracking data, transforming it from a messy spreadsheet to a robust, fully normalized MySQL database (5NF). The original data had redundancy, multi-valued attributes, and structural anomalies, all resolved through systematic normalization.

## Original Data Analysis
**Source Data Characteristics:**
- 15 records, 26 columns
- 7 unique projects (P001–P007)
- Redundancy: Each project repeated for multiple workers

**Problems Identified:**
1. **Repeating Groups:** Project info repeated for each worker
2. **Multi-valued Attributes:**
   - WorkerSkills (e.g., Carpentry|Framing)
   - WorkerCertifications (e.g., OSHA|First Aid)
   - SupplierPhones (e.g., 617-555-9000|617-555-9001)
   - MaterialSupplied, MaterialUnitCost (e.g., Concrete|Steel, 120|300)
   - EquipmentUsed, EquipmentRentalCost (e.g., Crane|Bulldozer, 5000|3000)
3. **Functional Dependencies:**
   - ProjectID → ProjectName, ProjectType, StartDate, EndDate, SiteAddress, SiteCity, SiteState
   - ClientName → ClientPhone, ClientEmail, ClientCity
   - SupervisorName → SupervisorPhone
   - WorkerName → WorkerPhone, WorkerHourlyRate
   - SupplierName → SupplierCity
4. **Transitive Dependencies:**
   - ProjectID → ClientName → ClientPhone, ClientEmail, ClientCity
   - ProjectID → SupervisorName → SupervisorPhone

## First Normal Form (1NF)
**Definition:**
A table is in 1NF if all columns contain atomic values, each column is a single type, each row is unique, and there are no repeating groups.

**Violations:**
- Multi-valued attributes (skills, certifications, phones, materials, equipment)
- Repeating groups (project info repeated for each worker)

**Transformation:**
1. Separate multi-valued attributes into individual rows
2. Create separate tables for each entity

**Resulting Tables:**
- projects
- clients
- supervisors
- workers
- worker_skills (junction)
- worker_certifications (junction)
- suppliers
- supplier_phones (junction)
- materials
- equipment
- project_workers (junction)
- project_supplier_materials (junction)
- project_equipment (junction)

**Justification:**
Repeating groups and multi-valued attributes are eliminated. All cells are atomic, and each table has a clear primary key.

## Second Normal Form (2NF)
**Definition:**
2NF requires 1NF and that all non-key attributes are fully dependent on the entire primary key (no partial dependencies).

**Analysis:**
After 1NF, all tables have single-column primary keys, so there are no partial dependencies.

**Justification:**
All tables are in 2NF because there are no composite primary keys and all non-key attributes depend on the whole primary key.

## Third Normal Form (3NF)
**Definition:**
3NF requires 2NF and that no transitive dependencies exist (non-key attributes depend only on the primary key).

**Violations:**
- ProjectID → ClientName → ClientPhone, ClientEmail, ClientCity
- ProjectID → SupervisorName → SupervisorPhone
- WorkerName → WorkerSkills, WorkerCertifications

**Transformation:**
Create lookup tables for skills, certifications, materials, equipment. Establish relationships via foreign keys.

**Justification:**
Transitive dependencies are eliminated. Client, worker, and supervisor info is stored once and referenced. Updates only needed in one place.


## Boyce-Codd Normal Form (BCNF)
**Definition:**
BCNF requires 3NF and that every determinant is a candidate key.

**Analysis:**
All tables satisfy BCNF: every determinant is a candidate key (PK or UNIQUE).

**Justification:**
All functional dependencies are on candidate keys, so BCNF is satisfied.

## Fourth Normal Form (4NF)
**Definition:**
4NF requires BCNF and that no multi-valued dependencies exist (except for key dependencies).

**Violations:**
- Workers have multiple skills and certifications
- Suppliers have multiple phones
- Projects use multiple materials and equipment

**Transformation:**
Create junction tables for multi-valued relationships:
- worker_skills (worker_id, skill_id)
- worker_certifications (worker_id, cert_id)
- supplier_phones (supplier_id, phone_number)
- project_supplier_materials (project_id, supplier_id, material_id, unit_cost)
- project_equipment (project_id, equipment_id, rental_cost)

**Justification:**
Multi-valued dependencies are eliminated. Adding new skills, certifications, phones, materials, or equipment is independent of other tables.


## Fifth Normal Form (5NF)
**Definition:**
5NF requires 4NF and that no join dependencies exist that are not implied by candidate keys.

**Analysis:**
The ternary relationship in project_supplier_materials (project_id, supplier_id, material_id, unit_cost) is necessary to maintain the association between project, supplier, and material with the specific unit cost. Decomposing into binary relationships would lose context.

**Justification:**
All join dependencies are implied by candidate keys. The schema is robust and flexible.

## Final Schema Summary
**Entity Relationship Diagram (Conceptual):**
clients ||--o< projects : "hires"
supervisors ||--o< project_workers : "supervises"
workers ||--o< project_workers : "assigned to"
workers ||--o< worker_skills : "has"
skills ||--o< worker_skills : "assigned to"
workers ||--o< worker_certifications : "has"
certifications ||--o< worker_certifications : "assigned to"
suppliers ||--o< supplier_phones : "has"
suppliers ||--o< project_supplier_materials : "provides"
materials ||--o< project_supplier_materials : "used in"
projects ||--o< project_workers : "has"
projects ||--o< project_supplier_materials : "uses"
projects ||--o< project_equipment : "uses"
equipment ||--o< project_equipment : "used in"

**Table Counts (After Normalization):**
projects: 7
clients: 4
supervisors: 3
workers: 5
skills: 13
certifications: 6
suppliers: 6
materials: 8
equipment: 6
worker_skills: 15
worker_certifications: 12
supplier_phones: 8
project_workers: 15
project_supplier_materials: 16
project_equipment: 13

## Data Integrity Improvements
| Aspect | Before (Spreadsheet) | After (5NF Database) |
|--------|----------------------|----------------------|
| Project Redundancy | P001 appears 3 times | P001 appears 1 time |
| Client Data | Repeated with each project | Stored once, referenced |
| Worker Skills | Pipe-separated in one column | Separate rows in junction table |
| Supplier Phones | Pipe-separated in one column | Separate rows in phone table |
| Update Anomalies | Update required in multiple rows | Single update, cascades automatically |
| Insert Anomalies | Cannot add client without project | Can add independent clients |
| Delete Anomalies | Deleting row loses project data | Can delete assignments without losing entity data |


## Benefits of Normalization
1. **Data Integrity:**
   - No duplicate data
   - Foreign key constraints ensure referential integrity
   - Check constraints ensure data validity
2. **Storage Efficiency:**
   - Original: 15 rows × 26 columns = 390 cells
   - Normalized: 14 tables, optimized storage
   - Redundant info eliminated
3. **Query Flexibility:**
   - Find workers with specific skills
   - Find projects using specific materials
   - Calculate total costs per project
   - Update supplier info in one place
4. **Maintenance:**
   - Adding skills, phones, etc. is just inserting rows
   - Changing client info cascades automatically


## Conclusion
The Big3 Construction database is now fully normalized to 5NF. All redundancy is eliminated, multi-valued attributes are separated, relationships are established, integrity is ensured, and all original data is preserved.


## Appendix: Original vs Normalized Data Comparison
**Original Data Sample (P001 - Downtown Plaza):**
Row 1: P001, Downtown Plaza, Commercial, ..., Metro Corp, ..., Mike Ross, ..., Carpentry|Framing, OSHA|First Aid, ..., BuildPro Supplies, ..., Concrete|Steel, 120|300, Crane|Bulldozer, 5000|3000
Row 2: P001, Downtown Plaza, Commercial, ..., Metro Corp, ..., Rachel Zane, ..., Electrical|Wiring, OSHA|Electrical License, ..., BuildPro Supplies, ..., Concrete|Steel, 120|300, Crane|Bulldozer, 5000|3000
Row 3: P001, Downtown Plaza, Commercial, ..., Metro Corp, ..., Harvey Specter, ..., Project Management|Planning, PMP|OSHA, ..., SteelWorks Inc, ..., Steel Beams, 500, Crane, 5000

**Normalized Data (P001 - Downtown Plaza):**
projects: P001, Downtown Plaza, Commercial, 2024-01-10, 2024-08-20, 123 Main St, Boston, MA, 1
project_workers: (P001, 1, 1), (P001, 2, 1), (P001, 3, 1)
worker_skills: (1, 1), (1, 2), (2, 4), (3, 5), (3, 6)
project_supplier_materials: (P001, 1, 1, 120), (P001, 1, 2, 300), (P001, 2, 3, 500)
project_equipment: (P001, 1, 5000), (P001, 2, 3000), (P001, 3, 5000)

Note: All details are stored in their respective tables and referenced by ID.

## Created by 
- Mugemanyi Manzi David
- Olubanjo Kolapo Emmanuel
- Paul Rwagasana 
- John Obule