USE big3_construction;
INSERT INTO clients (client_id, client_name, client_phone, client_email, client_city) VALUES
    (1, 'Metro Corp', '617-555-1000', 'contact@metrocorp.com', 'Boston'),
    (2, 'City Transit Auth', '617-555-1100', 'info@cta.gov', 'Boston'),
    (3, 'Retail Ventures', '401-555-1200', 'contact@retailventures.com', 'Providence'),
    (4, 'FutureTech Ltd', '212-555-1300', 'admin@futuretech.com', 'New York');

INSERT INTO supervisors (supervisor_id, supervisor_name, supervisor_phone) VALUES
    (1, 'John Carter', '617-555-2000'),
    (2, 'Sarah Lee', '617-555-2100'),
    (3, 'David Kim', '401-555-2200');

INSERT INTO workers (worker_id, worker_name, worker_phone, hourly_rate) VALUES
    (1, 'Mike Ross', '617-555-3001', 45),
    (2, 'Rachel Zane', '617-555-3002', 50),
    (3, 'Harvey Specter', '617-555-3003', 70),
    (4, 'Tom Hardy', '617-555-3004', 48),
    (5, 'Louis Litt', '617-555-3005', 55);

INSERT INTO skills (skill_id, skill_name) VALUES

INSERT INTO projects (project_id, project_name, project_type, start_date, end_date, site_address, site_city, site_state, client_id) VALUES
    ('P001', 'Downtown Plaza', 'Commercial', '2024-01-10', '2024-08-20', '123 Main St', 'Boston', 'MA', 1),
    ('P002', 'Harbor Bridge', 'Infrastructure', '2024-02-01', '2025-01-30', '78 Harbor Rd', 'Boston', 'MA', 2),
    ('P003', 'Riverside Apartments', 'Residential', '2024-03-15', '2024-11-15', '45 River Dr', 'Providence', 'RI', 3),
    ('P004', 'Green Tech Campus', 'Commercial', '2024-04-01', '2025-02-28', '900 Innovation Way', 'New York', 'NY', 4),
    ('P005', 'Sunset Mall Expansion', 'Commercial', '2024-05-10', '2024-12-20', '300 Sunset Blvd', 'Los Angeles', 'CA', 1),
    ('P006', 'Lakeside Villas', 'Residential', '2024-06-01', '2024-12-01', '88 Lakeview Rd', 'Orlando', 'FL', 3),
    ('P007', 'Airport Terminal Upgrade', 'Infrastructure', '2024-07-15', '2025-06-30', '1 Airport Way', 'Chicago', 'IL', 2);

INSERT INTO worker_skills (worker_id, skill_id) VALUES
    (1, 2),
    (1, 5),
    (2, 4),
    (2, 13),
    (3, 10),
    (3, 8),
    (1, 3),
    (4, 12),
    (4, 11),
    (2, 6),
    (4, 2),
    (5, 1),
    (5, 9),
    (3, 7),
    (4, 3);

INSERT INTO worker_certifications (worker_id, cert_id) VALUES
    (1, 4),
    (1, 2),
    (2, 4),
    (2, 1),
    (3, 5),
    (3, 4),
    (4, 4),
    (4, 6),
    (2, 2),
    (5, 3),
    (5, 2),
    (5, 4);

INSERT INTO supplier_phones (phone_id, supplier_id, phone_number) VALUES
    (1, 1, '617-555-9000'),
    (2, 1, '617-555-9001'),
    (3, 2, '312-555-8000'),
    (4, 2, '312-555-8001'),
    (5, 3, '305-555-7000'),
    (6, 4, '206-555-6000'),
    (7, 5, '619-555-6500'),
    (8, 6, '404-555-6600');

INSERT INTO project_workers (project_id, worker_id, supervisor_id) VALUES
    ('P001', 1, 1),
    ('P001', 2, 1),
    ('P001', 3, 1),
    ('P002', 1, 2),
    ('P002', 4, 2),
    ('P003', 2, 3),
    ('P003', 4, 3),
    ('P004', 1, 1),
    ('P004', 5, 1),
    ('P005', 3, 2),
    ('P005', 2, 2),
    ('P006', 4, 3),
    ('P006', 1, 3),
    ('P007', 5, 2),
    ('P007', 3, 2);

INSERT INTO project_supplier_materials (project_id, supplier_id, material_id, unit_cost) VALUES
    ('P001', 1, 3, 120.0),
    ('P001', 1, 6, 300.0),
    ('P001', 2, 7, 500.0),
    ('P002', 3, 5, 200.0),
    ('P002', 3, 3, 110.0),
    ('P003', 1, 1, 2.0),
    ('P003', 1, 2, 15.0),
    ('P004', 2, 7, 500.0),
    ('P004', 2, 4, 250.0),
    ('P004', 4, 4, 250.0),
    ('P005', 5, 3, 130.0),
    ('P005', 5, 8, 20.0),
    ('P006', 6, 3, 115.0),
    ('P007', 2, 7, 520.0),
    ('P007', 2, 3, 140.0),
    ('P007', 3, 5, 210.0);

INSERT INTO project_equipment (project_id, equipment_id, rental_cost) VALUES
    ('P001', 2, 5000.0),
    ('P001', 1, 3000.0),
    ('P002', 3, 4000.0),
    ('P002', 2, 5500.0),
    ('P003', 6, 800.0),
    ('P003', 4, 1200.0),
    ('P004', 2, 6000.0),
    ('P004', 5, 2000.0),
    ('P005', 1, 3200.0),
    ('P005', 6, 1000.0),
    ('P006', 6, 900.0),
    ('P007', 2, 6500.0),
    ('P007', 3, 4200.0);