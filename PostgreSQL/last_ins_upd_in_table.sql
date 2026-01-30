-- requre track_commit_timestamp=on 
SELECT
    MAX(pg_xact_commit_timestamp(xmin)) as last_record_time,
    NOW() - MAX(pg_xact_commit_timestamp(xmin)) as time_since_last_record
FROM test;
