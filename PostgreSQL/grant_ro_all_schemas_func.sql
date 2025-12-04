CREATE OR REPLACE FUNCTION grant_permissions_to_user(user_to_grant text)
RETURNS void AS $$
DECLARE
    grant_command text;
BEGIN
    FOR grant_command IN 
        SELECT 'GRANT SELECT ON ALL TABLES IN SCHEMA "' || n.nspname || '" TO "' || user_to_grant || '";' AS command
        FROM pg_namespace n
        WHERE n.nspname NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
        AND n.nspname NOT LIKE 'pg_%'
        AND n.nspname NOT LIKE 'information%'

        UNION ALL

        SELECT 'GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA "' || n.nspname || '" TO "' || user_to_grant || '";'
        FROM pg_namespace n
        WHERE n.nspname NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
        AND n.nspname NOT LIKE 'pg_%'
        AND n.nspname NOT LIKE 'information%'

        UNION ALL

        SELECT CASE 
            WHEN n.nspname = 'public' THEN 'alter default privileges for role "' || 
                (SELECT rolname FROM pg_roles WHERE oid = (SELECT datdba FROM pg_database WHERE datname = current_database())) || 
                '" in schema "' || n.nspname || '" grant SELECT on tables to "' || user_to_grant || '";'
            ELSE 'alter default privileges for role "' || u.rolname || '" in schema "' || n.nspname || '" grant SELECT on tables to "' || user_to_grant || '";'
        END
        FROM pg_namespace n
        JOIN pg_roles u ON n.nspowner = u.oid
        WHERE n.nspname NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
        AND n.nspname NOT LIKE 'pg_%'
        AND n.nspname NOT LIKE 'information%'

        UNION ALL

        SELECT CASE 
            WHEN n.nspname = 'public' THEN 'alter default privileges for role "' || 
                (SELECT rolname FROM pg_roles WHERE oid = (SELECT datdba FROM pg_database WHERE datname = current_database())) || 
                '" in schema "' || n.nspname || '" grant USAGE, SELECT ON SEQUENCES TO "' || user_to_grant || '";'
            ELSE 'alter default privileges for role "' || u.rolname || '" in schema "' || n.nspname || '" grant USAGE, SELECT ON SEQUENCES TO "' || user_to_grant || '";'
        END
        FROM pg_namespace n
        JOIN pg_roles u ON n.nspowner = u.oid
        WHERE n.nspname NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
        AND n.nspname NOT LIKE 'pg_%'
        AND n.nspname NOT LIKE 'information%'

        UNION ALL

        SELECT 'GRANT USAGE ON SCHEMA "' || n.nspname || '" TO "' || user_to_grant || '";'
        FROM pg_namespace n
        WHERE n.nspname NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
        AND n.nspname NOT LIKE 'pg_%'
        AND n.nspname NOT LIKE 'information%'

        ORDER BY command
    LOOP
        RAISE NOTICE 'Executing: %', grant_command;
        EXECUTE grant_command;
    END LOOP;
    
    RAISE NOTICE 'All privileges have been granted to user "%"', user_to_grant;
END;
$$ LANGUAGE plpgsql;



SELECT grant_permissions_to_user('bkp_db_usr_tmp');
