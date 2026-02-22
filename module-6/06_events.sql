USE big3_construction;

SHOW VARIABLES LIKE 'event_scheduler';

SET GLOBAL event_scheduler = ON;

CREATE TABLE IF NOT EXISTS archived_projects (
    project_id VARCHAR(10) PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    project_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    site_address VARCHAR(200) NOT NULL,
    site_city VARCHAR(50) NOT NULL,
    site_state VARCHAR(2) NOT NULL,
    client_id INT NOT NULL,
    archived_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP EVENT IF EXISTS ev_archive_old_projects;

CREATE EVENT ev_archive_old_projects
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP + INTERVAL 1 MONTH
DO
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO archived_projects (
        project_id,
        project_name,
        project_type,
        start_date,
        end_date,
        site_address,
        site_city,
        site_state,
        client_id
    )
    SELECT
        project_id,
        project_name,
        project_type,
        start_date,
        end_date,
        site_address,
        site_city,
        site_state,
        client_id
    FROM projects
    WHERE end_date IS NOT NULL
      AND end_date < CURDATE() - INTERVAL 5 YEAR;

    DELETE FROM projects
    WHERE end_date IS NOT NULL
      AND end_date < CURDATE() - INTERVAL 5 YEAR;

    COMMIT;
END;

SHOW EVENTS;