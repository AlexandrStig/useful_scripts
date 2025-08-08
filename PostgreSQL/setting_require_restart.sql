-- требует ли изменение конфига рестарта PostgreSQL
SELECT 
    name,
    setting,
    unit,
    context,
    CASE 
        WHEN context = 'postmaster' THEN 'Требуется restart'
        WHEN context = 'sighup' THEN 'Требуется reload (pg_reload_conf())'
        WHEN context IN ('user', 'superuser') THEN 'Можно изменить сразу (для текущей сессии)'
        ELSE 'Другой тип (' || context || ')'
    END AS change_requirement
FROM 
    pg_settings
WHERE 
    name = 'log_min_duration_statement';
