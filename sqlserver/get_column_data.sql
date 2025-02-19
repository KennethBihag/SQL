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