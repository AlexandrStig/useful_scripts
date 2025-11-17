-- Количество клиентских сеансов с группировкой по статусу 
SELECT state, count(*)
FROM pg_stat_activity WHERE backend_type = 'client backend'
GROUP BY 1 ORDER BY 2 DESC;
