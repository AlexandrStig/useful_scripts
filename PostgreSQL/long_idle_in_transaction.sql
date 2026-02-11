SELECT
    pid,
    datname,
    usename,
    state,
    backend_xmin,
    age(backend_xmin) AS xmin_age,
    now() - xact_start AS transaction_duration,
    now() - state_change AS idle_duration,
    wait_event_type,
    wait_event,
    left(query, 200) AS sample_query
FROM pg_stat_activity
WHERE backend_xmin IS NOT NULL          -- держит снимок данных
  AND state = 'idle in transaction'     -- только интересующий статус
ORDER BY age(backend_xmin) DESC \gx
