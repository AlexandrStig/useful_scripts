SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = current_database()
  AND state = 'idle'
  AND backend_type = 'client backend'
  AND pid <> pg_backend_pid();
