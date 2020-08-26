#!/bin/sh

# ENV validation
# config.xml

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

# dedimania.xml

if [ -z "$SERVER_LOGIN" ]; then
    echo "ERROR | Server login code was not given."
    echo "ERROR | Exiting..."
    exit 1
fi

if [ -z "$SERVER_PASSWORD" ]; then
    echo "ERROR | Server login password was not given."
    echo "ERROR | Exiting..."
    exit 1
fi

if [ -z "$SERVER_NATION" ]; then
    echo "WARN | Server nation was not given."
    echo "WARN | Assuming GER..."
    export SERVER_NATION="GER"
fi

envsubst < templates/_dedimania.xml > dedimania.xml

# localdatabase.xml

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

# creating plugin configuration files

[ -d "config" ] && [ ! -z "$(ls -A config/)" ] && ln -sf config/* .

# generate plugins.xml

header='<?xml version="1.0" encoding="utf-8" ?>
<aseco_plugins>'
footer='</aseco_plugins>'

{
printf "%s\n" "$header"
grep -oP '(?<=<plugin>).*(?=<\/plugin>)' templates/_plugins.xml | while read default
do
    if [ $(find plugins/ -maxdepth 1 -type f | sed 's#plugins\/##g' | grep -q "$default" -; echo $?) -eq 0 ]
    then
        printf "     <plugin>%s</plugin>\n" "$default"
    fi
done

find plugins/ -maxdepth 1 -type f | sed 's#plugins\/##g' | while read file
do
    if [ $(grep -oP '(?<=<plugin>).*(?=<\/plugin>)' templates/_plugins.xml | grep -q "$file" -; echo $?) -eq 1 ]
    then
        printf "     <plugin>%s</plugin>\n" "$file"
    fi
done
printf "%s\n" "$footer"
} > plugins.xml

exec "$@"
