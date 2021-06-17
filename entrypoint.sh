#!/bin/bash

. /etc/profile.d/vector.sh

# create a db and user(s)
# TODO - parameterise
if [ ! -f "$II_SYSTEM/ingres/data/db_created" ]; then
    if [ "$VECTOR_DB" ]; then
        echo "--- creating database $VECTOR_DB ---"
        createdb $VECTOR_DB
    else
        echo "!!! you must specify a database to create !!!"
        exit 1
    fi
    if [ "$VECTOR_USER" ]; then
        if [ ! "$VECTOR_PASS" ]; then
            echo "!!! you must use a password for the default user !!!"
            exit 1
        else
            echo "--- creating user $VECTOR_USER ---"
            echo "create user $VECTOR_USER with password='$VECTOR_PASS'\g"| sql iidbdb
        fi
    fi
    touch "$II_SYSTEM/ingres/data/db_created"
else
    echo "--- already set up, skipping db and user create ---"
fi

# so the container doesn't exit 
# vector should be process #1 but that's too hard for testing
echo "--- waiting forever ---"
exec sleep infinity
