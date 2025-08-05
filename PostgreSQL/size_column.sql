-- column size
SELECT pg_size_pretty(sum(pg_column_size(column_name))) FROM table_name;
