-- Percent of database sessions to this database that were terminated because connection to the client was lost. 
select sessions, 
        sessions_abandoned, 
        round(sessions_abandoned::numeric/sessions::numeric*100,2) as "%_of_abandoned"  
from pg_stat_database 
  where datname = 'datname';
