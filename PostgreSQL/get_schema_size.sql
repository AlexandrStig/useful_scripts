SELECT pg_size_pretty(sum(pg_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::bigint) FROM pg_tables 
WHERE schemaname = 'yourschema';
