USE big3_construction;

EXPLAIN SELECT * FROM workers WHERE last_name = 'Johnson';

CREATE INDEX idx_worker_lastname ON workers(last_name);

EXPLAIN SELECT * FROM workers WHERE last_name = 'Johnson';

EXPLAIN SELECT * FROM projects WHERE site_city = 'Boston' ORDER BY start_date;

CREATE INDEX idx_project_city_startdate ON projects(site_city, start_date);

EXPLAIN SELECT * FROM projects WHERE site_city = 'Boston' ORDER BY start_date;
