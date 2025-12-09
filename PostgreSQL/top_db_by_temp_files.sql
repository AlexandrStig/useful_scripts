select datname
  , temp_files
  , pg_size_pretty(temp_bytes) 
from pg_stat_database 
  ORDER BY temp_bytes 
  DESC LIMIT 5;
