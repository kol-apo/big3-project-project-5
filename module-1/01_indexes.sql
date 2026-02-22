USE big3_construction;

EXPLAIN SELECT * FROM workers WHERE last_name = 'Johnson';

CREATE INDEX idx_worker_lastname ON workers(last_name);

EXPLAIN SELECT * FROM workers WHERE last_name = 'Johnson';

CREATE INDEX idx_projects_city_startdate ON projects(site_city, start_date);
