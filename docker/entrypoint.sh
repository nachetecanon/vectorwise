#!/bin/bash

if [[ ! -f "$II_SYSTEM/ingres/data/db_created" ]]; then
    if [[ -n "$VECTOR_DB" ]]; then
        echo "--- creating database $VECTOR_DB ---"
        createdb $VECTOR_DB
    else
        echo "!!! you must specify a database to create !!!"
        exit 1
    fi
    if [[ -n "$VECTOR_USER" ]]; then
        if [[ -z "$VECTOR_PASS" ]]; then
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

