#!bash
for db in $( psql -Xt1c 'SELECT datname FROM pg_database WHERE datallowconn ORDER BY datname;' ); do
    psql -d $db -F ' ' -XAt1c 'SELECT rpad(current_database(), 40) AS db_name, nspname from pg_namespace where nspname = $$test_my_script_find_schema$$;';
