-- shows on screen values of a selected column for each table selected from a specified schema
DO LANGUAGE plpgsql $$
declare
    tRecord RECORD := null;
    uRec RECORD;
    tName VARCHAR;
    -- tableSuffix VARCHAR; -- if the table name is in a format WORDS_SUFFIX where suffix may be numbers, letters, or both, or anything
    myQuery VARCHAR;
 begin
   for tRecord in (SELECT tablename FROM pg_tables WHERE schemaname LIKE 'mySchema' AND tablename ~ 'myTableNameRegex')
      loop
         myQuery='';
         SELECT tRecord.tablename INTO tName;
         RAISE NOTICE 'TABLE NAME: %',tName;
         -- SELECT SUBSTRING(tName,suffixStartIndex,suffixLength) INTO tableSuffix;
         --SELECT myQuery||format('SELECT DISTINCT selectedColumn FROM mySchema.%I alias2 JOIN mySchema.aTableNameWithOutSuffix_%s alias1 ',tName,tableSuffix)||
         SELECT myQuery||format('SELECT DISTINCT selectedColumn FROM mySchema.%I alias2 JOIN mySchema.aTableName alias1 ',tName)||
            'ON alias1.column1=alias2.column1 WHERE column2 = col2Value AND column3 = col3Value'
            INTO myQuery;
         for uRec in EXECUTE myQuery
         loop
            RAISE NOTICE '    %',uRec.selectedColumn;
         end loop;
   end loop;
 end $$;
 