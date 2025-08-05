-- database size 
SELECT pg_size_pretty(pg_database_size(current_database()));
-- or
-- SELECT pg_size_pretty(pg_database_size('db_name'));
