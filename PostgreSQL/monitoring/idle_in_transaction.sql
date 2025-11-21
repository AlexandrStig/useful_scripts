-- idle in transaction клиентские сессии 
SELECT
	pid,
	datname,
	usename,
	application_name,
	state,
	wait_event_type || '.' || wait_event as wait_event,
	clock_timestamp() - xact_start as ts_age,
	clock_timestamp() - query_start as query_age,
	replace((query), E'\n', ' ') AS query,
	backend_type
FROM pg_stat_activity
WHERE backend_type = 'client backend'
AND state = 'idle in transaction'
ORDER BY ts_age DESC \gx
