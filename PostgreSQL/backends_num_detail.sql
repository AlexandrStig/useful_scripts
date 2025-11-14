-- Информация о подключенных клиентах (клиенты сгруппированы по адресу подключения, имени пользователя и имени БД)
SELECT client_addr, usename, datname, count(*)
FROM pg_stat_activity
GROUP BY 1,2,3
ORDER BY 4 DESC;
