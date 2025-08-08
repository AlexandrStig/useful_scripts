-- Запрос, который вернет ТОП 5 запросов, занимающих много времени (без сокращения текста запроса, с удалением из вывода переносов строк)
-- Требует установки EXTENSION'а pg_stat_statements

SELECT replace((query), E'\n', ' ') AS query,
       round(total_exec_time::numeric, 2) AS total_exec_time,
       calls,
       round(mean_exec_time::numeric, 2) AS mean,
       round((100 * total_exec_time / sum(total_exec_time::numeric) OVER ())::numeric, 2) AS percentage_cpu
FROM pg_stat_statements
ORDER BY total_exec_time DESC LIMIT 5;

-- Этот же запрос на ТОП 10 запросов (текст запросов сокращенный)
SELECT substring(query, 1, 50) AS short_query,
              round(total_exec_time::numeric, 2) AS total_exec_time,
              calls,
              round(mean_exec_time::numeric, 2) AS mean,
              round((100 * total_exec_time / sum(total_exec_time::numeric) OVER ())::numeric, 2) AS percentage_cpu
FROM  pg_stat_statements
ORDER BY total_exec_time DESC LIMIT 10;

-- запрос вернет топ 10 запросов с сортировкой по среднему времени выполнения
SELECT
    d.datname AS database_name,
    r.rolname AS username,
    substring(p.query, 1, 50) AS short_query,
    round(p.total_exec_time::numeric, 2) AS total_exec_time_ms,
    p.calls,
    round(p.mean_exec_time::numeric, 2) AS mean_exec_time_ms,
    round((100 * p.total_exec_time / sum(p.total_exec_time::numeric) OVER ())::numeric, 2) AS percentage_cpu
FROM
    pg_stat_statements p
JOIN
    pg_database d ON p.dbid = d.oid
JOIN
    pg_roles r ON p.userid = r.oid
ORDER BY
    mean_exec_time_ms DESC
LIMIT 10;
