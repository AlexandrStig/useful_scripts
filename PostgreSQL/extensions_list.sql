-- список установленных расширений (EXTENSIONS) с версиями
select * from pg_available_extensions where installed_version is not null;
