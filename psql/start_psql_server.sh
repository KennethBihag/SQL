#! /bin/bash

function StartSession(){
	un=$1
	dbn=$2
	echo Started session
	psql $dbn $un
	echo Ended session
	return 0
}

dbDataDir="$PROGRAMFILES/PostgreSQL/16/data"

pg_ctl status -D "$dbDataDir"
if (($? != 0))
then
	pg_ctl start -D "$dbDataDir"
	if (($? == 0))
	then
		echo at $dbDataDir
		StartSession kenneth mydb
	else
		echo Could not start server
	fi
else
	StartSession kenneth mydb
fi
