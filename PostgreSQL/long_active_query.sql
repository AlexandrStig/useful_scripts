 SELECT
    pid,
    datname,
    usename,
    client_addr,
    application_name,
    backend_start,
    query_start,
    state,
    wait_event_type,
    wait_event,
    query,
    now() - query_start AS duration
FROM
    pg_stat_activity
WHERE
    state = 'active'
    AND now() - query_start > interval '1 minute' -- Adjust the duration as needed
ORDER BY
    duration DESC \gx
