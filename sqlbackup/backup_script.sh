#!/bin/bash

# Database username
USER="root"
# Server hostname and Database name
HOSTNAME=$1
DATABASE=$2
# Database cmd for Restore and Backup
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
# File path for backup
BACKUP_PATH="/DB_Backup"
# File name appender Date format
DATEFORMAT=$(date +"%d-%b-%Y-%H-%M-%p")

# Check if the required number arguments are not passed in
if [ $# -ne 2 ]; then
    echo 'usage: "<./script.sh>" <hostname> <database>'
    exit 1
fi

# Check if the HOSTNAME is up and retry 2 times at 5 sec interval and if not fail the script with code 42  
checkIsServerUp() {
    if nc -z $HOSTNAME 22 2>/dev/null; then
        echo "$HOSTNAME up"
        return 1
    else
        echo "$HOSTNAME down"
        for i in $(seq 1 2); do
            checkIsServerUp()
            ret_value=$?
            [ $ret_value -eq 0 ] && break
            echo "> failed with $ret_value, waiting to retry..."
            sleep 5
        done
        exit(42);
    fi
}

# Backup the database 
createDBBackUp() {
    $MYSQLDUMP --host=$HOSTNAME --user=$USER --port=3306 -p $DATABASEPASS $DATABASE > $BACKUP_PATH/$DATABASE-$DATEFORMAT.sql
}

# Restore the database
createRestoreDB() {
    $MYSQL --host=$HOSTNAME --user=$USER --port=3306 -p $DATABASEPASS < $BACKUP_PATH/$DATABASE-$DATEFORMAT.sql
}

# Main check for missing args and perform backup and restore
if [[ -z "$HOSTNAME" ]]; then
  echo "Please enter the hostname"
elif [[ -z "$DATABASE" ]]; then
  echo "Please enter the database name"
else
  # Password prompt from user
  echo -n "Please enter the password for the database ? : "
  read DATABASEPASS
    if checkIsServerUp; then
        createDBBackUp()
        sleep 60
        createRestoreDB()
    else
        echo "check the server if its reachable"
    fi
fi
