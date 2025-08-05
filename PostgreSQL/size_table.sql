-- table size
SELECT pg_size_pretty(pg_total_relation_size('"schema_name"."table_name"'));
