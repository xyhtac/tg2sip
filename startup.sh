#!/bin/bash

cd /opt/tg2sip
FILE=/opt/tg2sip/db.sqlite
if [ -f "$FILE" ]; then
    echo "$FILE exists. Staring TG Client."
    ./tg2sip
else 
    echo "$FILE does not exist. Running GEN_DB."
    ./gen_db
fi
