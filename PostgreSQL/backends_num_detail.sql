-- Информация о подключенных клиентах (клиенты сгруппированы по адресу подключения, имени пользователя и имени БД)
-- client_addr=NULL - подключение выполнено через UNIX-сокет с того же узла, где запущен сервер СУБД
-- usename и datname = NULL - фоновые службы PostgreSQL
SELECT client_addr, usename, datname, count(*)
FROM pg_stat_activity
GROUP BY 1,2,3
ORDER BY 4 DESC;
