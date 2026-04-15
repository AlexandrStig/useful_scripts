-- Show role/user settings/parameters which was changed by ALTER ROLE/ALTER USER

SELECT
    COALESCE(datname, 'global') AS database_name,
    unnest(setconfig) AS setting
FROM pg_db_role_setting s
LEFT JOIN pg_database d ON s.setdatabase = d.oid
JOIN pg_roles r ON s.setrole = r.oid
WHERE r.rolname = 'aaevstegneev'
  AND setconfig IS NOT NULL
ORDER BY database_name;
