-- Получить наименование владельца БД 
WITH db_owner AS (
    SELECT r.rolname 
    FROM pg_database d 
    JOIN pg_roles r ON d.datdba = r.oid 
    WHERE d.datname = current_database()
)
-- Выдать права на существующие объекты
SELECT 'REVOKE ALL ON SCHEMA "' || n.nspname || '" FROM "bkp_db_usr_tmp";'
FROM pg_namespace n
WHERE n.nspname NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
  AND n.nspname NOT LIKE 'pg_%'
  AND n.nspname NOT LIKE 'information%'

UNION ALL

SELECT 'REVOKE ALL ON ALL TABLES IN SCHEMA "' || n.nspname || '" FROM "bkp_db_usr_tmp";'
FROM pg_namespace n
WHERE n.nspname NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
  AND n.nspname NOT LIKE 'pg_%'
  AND n.nspname NOT LIKE 'information%'

UNION ALL

SELECT 'REVOKE ALL ON ALL SEQUENCES IN SCHEMA "' || n.nspname || '" FROM "bkp_db_usr_tmp";'
FROM pg_namespace n
WHERE n.nspname NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
  AND n.nspname NOT LIKE 'pg_%'
  AND n.nspname NOT LIKE 'information%'

UNION ALL
-- Выдать права по умолчанию (на вновь создаваемые объекты)
SELECT 'ALTER DEFAULT PRIVILEGES FOR ROLE "' || (SELECT rolname FROM db_owner) || '" REVOKE ALL ON TABLES FROM "bkp_db_usr_tmp";'

UNION ALL

SELECT 'ALTER DEFAULT PRIVILEGES FOR ROLE "' || (SELECT rolname FROM db_owner) || '" REVOKE ALL ON SEQUENCES FROM "bkp_db_usr_tmp";'

UNION ALL

SELECT 'ALTER DEFAULT PRIVILEGES FOR ROLE "' || (SELECT rolname FROM db_owner) || '" REVOKE ALL ON SCHEMAS FROM "bkp_db_usr_tmp";'

ORDER BY 1 \gexec
