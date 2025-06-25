-- database size 
SELECT pg_size_pretty(pg_database_size(current_database()));
SELECT pg_size_pretty(pg_database_size('db_name'));

-- table size
SELECT pg_size_pretty(pg_total_relation_size('"public"."lid_subscription"'));

-- column size
SELECT pg_size_pretty(sum(pg_column_size(column_name))) FROM table_name;

-- список установленных расширений (EXTENSIONS) с версиями
select * from pg_available_extensions where installed_version is not null;

-- просмотр статистики по полю column_name в таблице table_name
select * from pg_stats where tablename = 'table_name' and attname = 'column_name';		

-- get md5 hash password
SELECT rolpassword from pg_authid WHERE rolname IN ('username');

-- список индексов на таблице table_name
select * from pg_indexes where tablename='table_name';

-- частота использования индекса idx_name
select indexrelname, idx_scan from pg_stat_user_indexes where indexrelname= 'idx_name';

-- просмотреть установленные конфиги для определенной БД
SELECT d.datname, s.setconfig 
FROM pg_database d
LEFT JOIN pg_db_role_setting s ON d.oid = s.setdatabase
WHERE d.datname = 'db_name'; -- or current_database()

-- или так
SELECT datname, unnest(setconfig) AS setting
FROM pg_database d
LEFT JOIN pg_db_role_setting s ON d.oid = s.setdatabase
WHERE datname = 'db_name' AND setconfig IS NOT NULL; -- or current_database()

-- или так
psql -d test -c "SHOW config_name;"
