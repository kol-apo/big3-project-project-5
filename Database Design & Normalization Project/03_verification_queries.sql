USE big3_construction;

-- Count all main entities
SELECT 'Projects' AS entity, COUNT(*) AS total FROM projects
UNION ALL
SELECT 'Clients', COUNT(*) FROM clients
UNION ALL
SELECT 'Supervisors', COUNT(*) FROM supervisors
UNION ALL
SELECT 'Workers', COUNT(*) FROM workers
UNION ALL
SELECT 'Skills', COUNT(*) FROM skills
UNION ALL
SELECT 'Certifications', COUNT(*) FROM certifications
UNION ALL
SELECT 'Suppliers', COUNT(*) FROM suppliers
UNION ALL
SELECT 'Materials', COUNT(*) FROM materials
UNION ALL
SELECT 'Equipment', COUNT(*) FROM equipment
UNION ALL
SELECT 'Worker-Skill Assignments', COUNT(*) FROM worker_skills
UNION ALL
SELECT 'Worker-Certification Assignments', COUNT(*) FROM worker_certifications
UNION ALL
SELECT 'Supplier Phones', COUNT(*) FROM supplier_phones
UNION ALL
SELECT 'Project-Worker Assignments', COUNT(*) FROM project_workers
UNION ALL
SELECT 'Project-Material Assignments', COUNT(*) FROM project_supplier_materials
UNION ALL
SELECT 'Project-Equipment Assignments', COUNT(*) FROM project_equipment;

SELECT DISTINCT 
    p.project_id,
    p.project_name,
    m.material_name,
    psm.unit_cost
FROM projects p
JOIN project_supplier_materials psm ON p.project_id = psm.project_id
JOIN materials m ON psm.material_id = m.material_id
WHERE m.material_name = 'Concrete'
ORDER BY p.project_id;

SELECT 
    w.worker_name,
    w.worker_phone,
    w.hourly_rate,
    GROUP_CONCAT(DISTINCT s.skill_name ORDER BY s.skill_name SEPARATOR ', ') AS skills,
    GROUP_CONCAT(DISTINCT c.cert_name ORDER BY c.cert_name SEPARATOR ', ') AS certifications
FROM workers w
LEFT JOIN worker_skills ws ON w.worker_id = ws.worker_id
LEFT JOIN skills s ON ws.skill_id = s.skill_id
LEFT JOIN worker_certifications wc ON w.worker_id = wc.worker_id
LEFT JOIN certifications c ON wc.cert_id = c.cert_id
GROUP BY w.worker_id, w.worker_name, w.worker_phone, w.hourly_rate
ORDER BY w.worker_name;

SELECT 
    p.project_id,
    p.project_name,
    COUNT(DISTINCT pe.equipment_id) AS equipment_count,
    SUM(pe.rental_cost) AS total_rental_cost
FROM projects p
JOIN project_equipment pe ON p.project_id = pe.project_id
GROUP BY p.project_id, p.project_name
ORDER BY total_rental_cost DESC;

SELECT 
    site_city,
    COUNT(DISTINCT project_id) AS project_count,
    GROUP_CONCAT(DISTINCT project_name ORDER BY project_name SEPARATOR ', ') AS projects
FROM projects
GROUP BY site_city
ORDER BY project_count DESC;


SELECT 
    p.project_id,
    p.project_name,
    p.project_type,
    c.client_name,
    c.client_phone AS client_contact,
    COUNT(DISTINCT pw.worker_id) AS worker_count,
    COUNT(DISTINCT psm.material_id) AS material_types,
    COUNT(DISTINCT pe.equipment_id) AS equipment_types
FROM projects p
JOIN clients c ON p.client_id = c.client_id
LEFT JOIN project_workers pw ON p.project_id = pw.project_id
LEFT JOIN project_supplier_materials psm ON p.project_id = psm.project_id
LEFT JOIN project_equipment pe ON p.project_id = pe.project_id
GROUP BY p.project_id, p.project_name, p.project_type, c.client_name, c.client_phone
ORDER BY p.project_id;

SELECT 
    s.supplier_name,
    s.supplier_city,
    COUNT(sp.phone_id) AS phone_count,
    GROUP_CONCAT(sp.phone_number SEPARATOR ', ') AS phone_numbers
FROM suppliers s
JOIN supplier_phones sp ON s.supplier_id = sp.supplier_id
GROUP BY s.supplier_id, s.supplier_name, s.supplier_city
HAVING COUNT(sp.phone_id) > 1
ORDER BY phone_count DESC;

SELECT 
    w.worker_name,
    w.hourly_rate,
    COUNT(DISTINCT pw.project_id) AS project_count,
    GROUP_CONCAT(DISTINCT p.project_name ORDER BY p.project_name SEPARATOR ', ') AS projects
FROM workers w
JOIN project_workers pw ON w.worker_id = pw.worker_id
JOIN projects p ON pw.project_id = p.project_id
GROUP BY w.worker_id, w.worker_name, w.hourly_rate
HAVING COUNT(DISTINCT pw.project_id) > 1
ORDER BY project_count DESC;