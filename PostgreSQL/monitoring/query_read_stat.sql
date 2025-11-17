-- Статистика по запросам относительно чтения с диска
SELECT 
    queryid,
    LEFT(query, 100) as short_query,
    calls,
    total_exec_time,
    mean_exec_time,
    rows,
    -- Блоки с диска
    shared_blks_read,
    -- Блоки из кэша
    shared_blks_hit,
    -- Временные файлы на диске
    temp_blks_read,
    temp_blks_written,
    -- Чтение с диска в МБ
    round((shared_blks_read * 8.0) / 1024, 2) as shared_read_mb,
    round((temp_blks_read * 8.0) / 1024, 2) as temp_read_mb,
    -- Эффективность кэша
    round(100.0 * shared_blks_hit / nullif(shared_blks_hit + shared_blks_read, 0), 2) as cache_hit_ratio
FROM pg_stat_statements 
WHERE shared_blks_read > 0 OR temp_blks_read > 0
ORDER BY (shared_blks_read + temp_blks_read) DESC 
LIMIT 15;
