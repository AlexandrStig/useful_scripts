-- How much sessions is in different state
SELECT 
    state,
    count(*) as session_count,
    round(100.0 * count(*) / (SELECT count(*) FROM pg_stat_activity), 2) as percentage
FROM 
    pg_stat_activity
WHERE 
    datname = current_database()  -- только для текущей БД (можно убрать для всех БД)
GROUP BY 
    state
ORDER BY 
    session_count DESC;
