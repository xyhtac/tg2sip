#!/bin/bash

FILE=/opt/tg2sip/db.sqlite
if [ -f "$FILE" ]; then
    echo "$FILE exists. Staring TG Client."
    sh "./tg2sip"
else 
    echo "$FILE does not exist. Running GEN_DB."
    sh "./gen_db"
fi
