-- Мониторинг отставания слотов
SELECT slot_name,
       database,
       active,
       pg_size_pretty(
         pg_wal_lsn_diff(pg_current_wal_lsn(), restart_lsn)
       ) as lag_size,
       pg_size_pretty(
         pg_wal_lsn_diff(pg_current_wal_lsn(), confirmed_flush_lsn)
       ) as flush_lag_size,
       -- Когда слот приближается к лимиту
       CASE WHEN pg_wal_lsn_diff(pg_current_wal_lsn(), restart_lsn) > 
                 (setting::bigint * 0.8) 
            THEN 'WARNING'
            ELSE 'OK'
       END as status
FROM pg_replication_slots,
     pg_settings 
WHERE pg_settings.name = 'max_slot_wal_keep_size';
