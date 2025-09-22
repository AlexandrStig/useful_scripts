-- Show tables and sequences owned by user
select c.relname, relkind
from
    pg_class c
    inner join
    pg_roles r on r.oid = c.relowner
where
    r.rolname = 'aaevstegneev'
     and
    c.relkind in ('r', 'S')
order by c.relname ;
