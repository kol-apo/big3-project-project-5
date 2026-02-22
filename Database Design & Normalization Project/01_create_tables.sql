CREATE DATABASE IF NOT EXISTS big3_construction;
USE big3_construction;

-- 1. CLIENTS TABLE
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL UNIQUE,
    client_phone VARCHAR(20) NOT NULL,
    client_email VARCHAR(100) NOT NULL,
    client_city VARCHAR(50) NOT NULL,
    CONSTRAINT chk_client_phone CHECK (client_phone REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'),
    CONSTRAINT chk_client_email CHECK (client_email LIKE '%@%.%')
);

-- 2. SUPERVISORS TABLE
CREATE TABLE supervisors (
    supervisor_id INT AUTO_INCREMENT PRIMARY KEY,
    supervisor_name VARCHAR(100) NOT NULL,
    supervisor_phone VARCHAR(20) NOT NULL,
    CONSTRAINT chk_supervisor_phone CHECK (supervisor_phone REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$')
);

-- 3. WORKERS TABLE
CREATE TABLE workers (
    worker_id INT AUTO_INCREMENT PRIMARY KEY,
    worker_name VARCHAR(100) NOT NULL,
    worker_phone VARCHAR(20) NOT NULL,
    hourly_rate DECIMAL(10, 2) NOT NULL CHECK (hourly_rate > 0),
    CONSTRAINT chk_worker_phone CHECK (worker_phone REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$')
);

-- 4. SKILLS TABLE (Lookup)
CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(50) NOT NULL UNIQUE
);

-- 5. CERTIFICATIONS TABLE (Lookup)
CREATE TABLE certifications (
    cert_id INT AUTO_INCREMENT PRIMARY KEY,
    cert_name VARCHAR(50) NOT NULL UNIQUE
);

-- 6. SUPPLIERS TABLE
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL UNIQUE,
    supplier_city VARCHAR(50) NOT NULL
);

-- 7. MATERIALS TABLE (Lookup)
CREATE TABLE materials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(50) NOT NULL UNIQUE
);

-- 8. EQUIPMENT TABLE (Lookup)
CREATE TABLE equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================
-- PROJECT TABLE (Central Entity)
-- ============================================

CREATE TABLE projects (
    project_id VARCHAR(10) PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    project_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    site_address VARCHAR(200) NOT NULL,
    site_city VARCHAR(50) NOT NULL,
    site_state VARCHAR(2) NOT NULL,
    client_id INT NOT NULL,
    CONSTRAINT fk_project_client FOREIGN KEY (client_id) REFERENCES clients(client_id),
    CONSTRAINT chk_project_id CHECK (project_id LIKE 'P%'),
    CONSTRAINT chk_dates CHECK (end_date >= start_date)
);

-- ============================================
-- JUNCTION TABLES (Many-to-Many Relationships)
-- ============================================

-- 9. WORKER_SKILLS (Workers can have multiple skills)
CREATE TABLE worker_skills (
    worker_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (worker_id, skill_id),
    CONSTRAINT fk_ws_worker FOREIGN KEY (worker_id) REFERENCES workers(worker_id) ON DELETE CASCADE,
    CONSTRAINT fk_ws_skill FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
);

-- 10. WORKER_CERTIFICATIONS (Workers can have multiple certifications)
CREATE TABLE worker_certifications (
    worker_id INT NOT NULL,
    cert_id INT NOT NULL,
    PRIMARY KEY (worker_id, cert_id),
    CONSTRAINT fk_wc_worker FOREIGN KEY (worker_id) REFERENCES workers(worker_id) ON DELETE CASCADE,
    CONSTRAINT fk_wc_cert FOREIGN KEY (cert_id) REFERENCES certifications(cert_id) ON DELETE CASCADE
);

-- 11. SUPPLIER_PHONES (Suppliers can have multiple phones - multi-valued attribute)
CREATE TABLE supplier_phones (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    CONSTRAINT fk_sp_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE CASCADE,
    CONSTRAINT chk_supplier_phone CHECK (phone_number REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$')
);

-- 12. PROJECT_WORKERS (Workers assigned to projects with supervisors)
CREATE TABLE project_workers (
    project_id VARCHAR(10) NOT NULL,
    worker_id INT NOT NULL,
    supervisor_id INT NOT NULL,
    PRIMARY KEY (project_id, worker_id),
    CONSTRAINT fk_pw_project FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    CONSTRAINT fk_pw_worker FOREIGN KEY (worker_id) REFERENCES workers(worker_id) ON DELETE CASCADE,
    CONSTRAINT fk_pw_supervisor FOREIGN KEY (supervisor_id) REFERENCES supervisors(supervisor_id)
);

-- 13. PROJECT_SUPPLIER_MATERIALS (Materials supplied by suppliers for projects)
CREATE TABLE project_supplier_materials (
    project_id VARCHAR(10) NOT NULL,
    supplier_id INT NOT NULL,
    material_id INT NOT NULL,
    unit_cost DECIMAL(10, 2) NOT NULL CHECK (unit_cost >= 0),
    PRIMARY KEY (project_id, supplier_id, material_id),
    CONSTRAINT fk_psm_project FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    CONSTRAINT fk_psm_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CONSTRAINT fk_psm_material FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

-- 14. PROJECT_EQUIPMENT (Equipment used on projects)
CREATE TABLE project_equipment (
    project_id VARCHAR(10) NOT NULL,
    equipment_id INT NOT NULL,
    rental_cost DECIMAL(10, 2) NOT NULL CHECK (rental_cost >= 0),
    PRIMARY KEY (project_id, equipment_id),
    CONSTRAINT fk_pe_project FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    CONSTRAINT fk_pe_equipment FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);