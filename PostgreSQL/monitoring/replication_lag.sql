SELECT 
    client_addr,
    usename,
    application_name,
    state,
    sync_state,
    pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn)) as replication_lag_bytes,
    (pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn) / 1024 / 1024)::numeric(10,2) as replication_lag_mb,
    CASE 
        WHEN replay_lag IS NOT NULL THEN 
            EXTRACT(EPOCH FROM replay_lag)::numeric(10,2)
        ELSE 
            NULL 
    END as replication_lag_seconds
FROM pg_stat_replication;
