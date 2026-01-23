-- Список всех объектов в БД (можно использовать для сравнения консистентности нескольких БД между собой относительно кол-ва и наименований объектов (не данных))
SELECT 
    n.nspname as schema,
    c.relname as object_name,
    CASE c.relkind
        WHEN 'r' THEN 'TABLE'
        WHEN 'i' THEN 'INDEX'
        WHEN 'S' THEN 'SEQUENCE'
        WHEN 'v' THEN 'VIEW'
        WHEN 'm' THEN 'MATERIALIZED VIEW'
        WHEN 'c' THEN 'TYPE'
        WHEN 't' THEN 'TOAST TABLE'
        WHEN 'f' THEN 'FOREIGN TABLE'
        WHEN 'p' THEN 'PARTITIONED TABLE'
        ELSE c.relkind::text
    END as object_type,
    obj_description(c.oid) as description
FROM 
    pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE 
    c.relkind IN ('r', 'i', 'S', 'v', 'm', 't', 'f', 'p')
    AND n.nspname NOT IN ('pg_catalog', 'information_schema')
    AND n.nspname NOT LIKE 'pg_%'
ORDER BY 
    n.nspname, 
    object_type,
    c.relname;
