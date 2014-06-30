#!/bin/bash

DB_USER='root'
DB_NAME='rocketrip'
APP_ROOT='/app'

# Optional:
# The first argument is should be the path to a SQL file, like a database dump file.
# The file will be run on the database.
DUMP_FILE=$1

echo "CREATE DATABASE $DB_NAME" | mysql -uroot

# Run Django commands to set up the database
$APP_ROOT/manage.py syncdb --noinput
$APP_ROOT/manage.py migrate --no-initial-data

if [ -e "$DUMP_FILE" ]; then
	mysql -uroot $DB_NAME < $DUMP_FILE
fi

