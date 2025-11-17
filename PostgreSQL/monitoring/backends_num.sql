-- текущее количество клиентских процессов, подключенных к БД
SELECT datname, numbackends FROM pg_stat_database
ORDER BY numbackends DESC;
