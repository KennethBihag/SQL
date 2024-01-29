@ECHO OFF
SetLocal  EnableExtensions EnableDelayedExpansion

set "dbDataDir=%ProgramFiles%\PostgreSQL\16\data"
pg_ctl status -D "%dbDataDir%"
echo %errorlevel%
if errorlevel 3 (
	pg_ctl start -D "%dbDataDir%"
	if errorlevel 3 echo Successfully started server at %dbDataDir%
	call :StartSession kenneth mydb
) else (
	echo Server is already running at %dbDataDir%
	call :StartSession kenneth mydb
)

exit /b 0
EndLocal

:StartSession
set un=%1
set dbn=%2
echo Started session
psql %dbn% %un%
echo Ended session
exit /b 0