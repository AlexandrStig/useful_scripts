select datname
  , temp_files
  , pg_size_pretty(temp_bytes) 
from pg_stat_database 
  WHERE temp_files > 0
  ORDER BY temp_bytes 
  DESC LIMIT 5;
