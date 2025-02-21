#! /bin/bash
_sqlcmd="sqlcmd -o $outputFile -s ',' -Y $width -y $width -Q"
## get objects with name pattern
# $_sqlcmd "SELECT name, object_id FROM sys.system_views WHERE name LIKE '$ptrn';"

## list all databases available
# $_sqlcmd 'SELECT name FROM sys.databases;'

## list users
$_sqlcmd 'SELECT name FROM sys.database_principals; SELECT name FROM sys.server_principals;'

## list stored procedures
# $_sqlcmd "SELECT name,object_id FROM sys.system_objects WHERE type = 'P' ORDER BY name;"