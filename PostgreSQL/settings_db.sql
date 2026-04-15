-- Show database settings/parameters which was changed by ALTER DATABASE

SELECT datname, unnest(setconfig) AS setting
FROM pg_database d
LEFT JOIN pg_db_role_setting s ON d.oid = s.setdatabase
WHERE datname = current_database() AND setconfig IS NOT NULL;