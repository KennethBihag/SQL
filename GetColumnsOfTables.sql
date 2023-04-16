-- get desired column names of desired tables from specified schemas

SELECT t.tablename,c.column_name,c.column_default,c.data_type,c.is_nullable FROM pg_tables t
JOIN information_schema.columns c
ON table_name=tablename
WHERE schemaname LIKE 'SCHEMA_NAME_REGEX' AND tablename ~ 'TABLE_NAME_REGEX' AND column_name ~* 'COL_NAME_REGEX';
