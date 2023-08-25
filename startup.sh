#!/bin/bash

FILE=/opt/tg2sip/db.sqlite
if [ -f "$FILE" ]; then
    echo "$FILE exists. Staring TG Client."
    sh /opt/tg2sip/tg2sip
else 
    echo "$FILE does not exist. Running DB_INIT."
    sh /opt/tg2sip/db_init
fi
