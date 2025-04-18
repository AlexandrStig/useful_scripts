-- Show size of WAL files retained in the pg_wal by replication slots
select slot_name, active,
pg_size_pretty(pg_current_wal_lsn() - restart_lsn) AS backlog,
wal_status, safe_wal_size
FROM pg_replication_slots;
