-- Procedure to show some columns from some tables from a specified schema in a specific database
DO LANGUAGE plpgsql $$
declare
 tname name := null;
 r RECORD := null;
 s RECORD := null;
 begin
 for r in (select schemaname,tablename from pg_tables where schemaname = 'schemaName' and tablename ~ 'regexForTable')
 loop
    tname = r.tablename;
    RAISE NOTICE '%s :',tname;
    for s in EXECUTE format('SELECT col1,col2,... FROM %I',tname)
    loop
        RAISE NOTICE '  %s - %s - ...',s.col1,s.col2,...;
    end loop;
 end loop;
end
$$;
