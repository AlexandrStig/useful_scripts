#!/bin/bash

# Параметры подключения (каждую строку нужно заполнить корректно)
HOST="hostname"
PORT="5432"
USER="user_name"
SQL_FILE="/path/to/file/file.sql"
LOG_FILE="/path/to/log/curdb_log_$(date +%Y%m%d).log"
PGPASSWORD="*****"
STARTDB="name_of_thr_first_db_in_cluster"

# Список исключаемых БД (опционально)
EXCLUDE_DBS="template0,template1,postgres"

echo "Начало выполнения: $(date)" | tee -a "$LOG_FILE"
echo "Хост: $HOST, Порт: $PORT, Пользователь: $USER" | tee -a "$LOG_FILE"
echo "SQL файл: $SQL_FILE" | tee -a "$LOG_FILE"
echo "==========================================" | tee -a "$LOG_FILE"

# Получить список всех баз данных
DATABASES=$(psql -h $HOST -p $PORT -U $USER -d $STARTDB -t -c "
SELECT datname
FROM pg_database
WHERE datistemplate = false
AND datname NOT IN ('$EXCLUDE_DBS')
ORDER BY datname;")

# Проверить, что файл существует
if [ ! -f "$SQL_FILE" ]; then
    echo "ОШИБКА: Файл $SQL_FILE не найден!" | tee -a "$LOG_FILE"
    exit 1
fi

# Выполнить скрипт в каждой базе данных и логируем вывод
for DB in $DATABASES; do
    echo "Database: $DB" | tee -a "$LOG_FILE"
    echo "Start: $(date '+%H:%M:%S')" | tee -a "$LOG_FILE"

    if PGPASSWORD=$PGPASSWORD psql -h $HOST -p $PORT -U $USER -d "$DB" -f "$SQL_FILE" >> "$LOG_FILE" 2>&1; then
        echo "✅ Ok: $DB completed" | tee -a "$LOG_FILE"
    else
        echo "❌ ERROR: $DB" | tee -a "$LOG_FILE"
    fi

    echo "Finish: $(date '+%H:%M:%S')" | tee -a "$LOG_FILE"
    echo "------------------------------------------" | tee -a "$LOG_FILE"

    # опционально паузу между БД
    # sleep 1
done

echo "Файл выполнен на всех указанных БД: $(date)" | tee -a "$LOG_FILE"
echo "Лог сохранен в: $LOG_FILE" | tee -a "$LOG_FILE"
