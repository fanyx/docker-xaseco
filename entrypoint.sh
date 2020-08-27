#!/bin/bash

# parse plugin and core configuration files

scripts/config.sh

# validate ENV vars
# config.xml - if no custom file is present
if [ ! -f config.xml ]; then 
    if [ -z "$MASTERADMIN_LOGIN" ]; then
        echo "WARN | No masteradmin login was specified. It is advised to have the system administrator also function as masteradmin."
        echo "WARN | continuing..."
    fi

    if [ -z "$SUPERADMIN_PASSWORD" ]; then
        echo "ERROR | No superadmin password was given."
        echo "ERROR | exiting..."
        exit 1
    fi

    if [ -z "$TMSERVER_HOST" ]; then
        echo "WARN | Host address of the trackmania server was not given."
        echo "WARN | Assuming 'trackmania'..."
        export TMSERVER_HOST="trackmania"
    fi

    if [ -z "$TMSERVER_PORT" ]; then
        echo "WARN | Port for the connection to trackmania server was not given."
        echo "WARN | Assuming 5000..."
        export TMSERVER_PORT="5000"
    fi

    envsubst < templates/_config.xml > config.xml
fi

# localdatabase.xml - if no custom file is present
if [ ! -f localdatabase.xml ]; then
    if [ -z "$MYSQL_HOST" ]; then
        echo "WARN | MySQL host address was not given."
        echo "WARN | Assuming 'db'..."
        export MYSQL_HOST="db"
    fi

    if [ -z "$MYSQL_LOGIN" ]; then
        echo "ERROR | MySQL login was not given."
        echo "ERROR | Exiting..."
        exit 1
    fi

    if [ -z "$MYSQL_PASSWORD" ]; then
        echo "ERROR | MySQL password was not given."
        echo "ERROR | Exiting..."
        exit 1
    fi

    if [ -z "$MYSQL_DATABASE" ]; then
        echo "ERROR | MySQL database was not given."
        echo "ERROR | Exiting..."
        exit 1
    fi

    envsubst < templates/_localdatabase.xml localdatabase.xml
fi

# generate plugins.xml

scripts/plugins.sh

exec "$@"
