-- Show tables and sequences owned by user with schema information
select 
    n.nspname as schema_name,
    c.relname, 
    c.relkind
from
    pg_class c
    inner join pg_roles r on r.oid = c.relowner
    inner join pg_namespace n on n.oid = c.relnamespace
where
    r.rolname = 'users-and-locations'
    and c.relkind in ('r', 'S')
order by 
    n.nspname,
    c.relname ;
