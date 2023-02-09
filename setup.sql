DROP DATABASE IF EXISTS mydatabase
    WITH(FORCE);
DROP USER IF EXISTS kenneth; 
CREATE USER kenneth WITH
    SUPERUSER
    LOGIN
    PASSWORD 'kenneth';
-- --ALTER USER Kenneth WITH PASSWORD 'kenneth';
CREATE DATABASE myDatabase WITH
   OWNER Kenneth;

DROP TABLE IF EXISTS geomdata;

CREATE TABLE geomdata (
    _faces int,
    _guid VARCHAR primary key not null,
    _body  json
);

-- ALTER TABLE geomdata ALTER COLUMN _body
--     TYPE TEXT;

COPY geomdata (_faces,_guid,_body)
    FROM './geomDataSample.tsv'
    WITH (FORMAT CSV, DELIMITER E'\t');

-- returns number of faces in a mesh from geometry body property
CREATE OR REPLACE FUNCTION faceCount(body json)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE
answer INT := 0;
jsonElem JSON;
BEGIN
 FOR jsonElem IN
  SELECT json_array_elements($1)
 LOOP
  SELECT json_array_length((jsonElem#>>'{Faces}')::json)+answer INTO answer;
 END LOOP;
 RETURN answer;
END;
$$;

DO $$
 DECLARE
  rec int = 0;
 BEGIN
  FOR rec IN (
   SELECT faces from (select faceCount(_body) as faces from geomdata) sq
    order by faces)
  LOOP
   RAISE NOTICE 'No. of faces is: %',rec;
  END LOOP;
END;
$$;

--export some data to file
CREATE OR REPLACE VIEW someGeomData as
    SELECT * from (select
        faceCount(_body) as faces,
        _guid
        from geomdata) sq
        order by faces desc offset 2 limit 3;
COPY (select * from someGeomData )
    TO './output.tsv'
    WITH (DELIMITER E'\t');