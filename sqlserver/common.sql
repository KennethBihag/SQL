-- Get column info from table

:setvar tableName CatColor
:setvar dbName MyOwnDB

SELECT d.*, t.name, t.max_length
FROM
(	SELECT o.name as TName, c.name as CName, c.system_type_id
	FROM $(dbName).sys.all_objects as o
	JOIN $(dbName).sys.all_columns as c
	ON o.object_id = c.object_id
	WHERE o.name = '$(tableName)') as d
JOIN sys.types as t
ON t.system_type_id = d.system_type_id;

CREATE DATABASE [PkmnDb] ;

CREATE TABLE [PkmnDb].[dbo].[name] (
	id INT IDENTITY PRIMARY KEY,
	name VARCHAR(16) UNIQUE);


USE PkmnDb;
DROP TABLE IF EXISTS pokemon;
CREATE TABLE dbo.[pokemon]
(
	id INT NOT NULL IDENTITY,
	species CHAR(16) NOT NULL DEFAULT 'bulbasaur',
	natl_id SMALLINT NOT NULL DEFAULT 1,
	name_id INT,
	PRIMARY KEY (id),
	CHECK (natl_id > 0 AND natl_id < 494),
	FOREIGN KEY (name_id) REFERENCES PkmnDb.dbo.name (id)
)

CREATE TABLE dbo.moveset (
	id INT NOT NULL IDENTITY,
	move1 VARCHAR(16), move2 VARCHAR(16), move3 VARCHAR(16), move4 VARCHAR(16),
	name_id INT NOT NULL,
	FOREIGN KEY (name_id) REFERENCES dbo.name (id) ON DELETE CASCADE
)