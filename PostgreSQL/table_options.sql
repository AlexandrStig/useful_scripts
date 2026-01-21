-- list of not default settings on tables 
SELECT 
    n.nspname AS schema_name,
    c.relname AS table_name,
    c.reloptions AS table_options
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE c.relkind IN ('r', 'p') -- обычные и партиционированные таблицы
    AND n.nspname NOT IN ('pg_catalog', 'information_schema')
    AND (c.reloptions IS NOT NULL)
ORDER BY n.nspname, c.relname;
