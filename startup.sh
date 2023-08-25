#!/bin/bash

FILE=/opt/tg2sip/db.sqlite
if [ -f "$FILE" ]; then
    echo "$FILE exists. Staring TG Client."
    /opt/tg2sip/tg2sip
else 
    echo "$FILE does not exist. Running GEN_DB."
    /opt/tg2sip/gen_db
fi
