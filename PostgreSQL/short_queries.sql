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

  
-- Долгие транзакции (>5 минут)
SELECT pid, now() - xact_start AS duration, query 
FROM pg_stat_activity 
WHERE state != 'idle' AND usename = 'keycloak'
ORDER BY duration DESC;

-- посчитать кол-во строк в таблице без select count(*)
SELECT (reltuples/relpages*pg_relation_size(:'relname')/8192)::bigint FROM pg_class WHERE oid = :'relname'::regclass;

