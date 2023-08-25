#!/bin/bash

cd /opt/tg2sip
FILE=/opt/tg2sip/db.sqlite
if [ -f "$FILE" ]; then
    echo "$FILE exists. Starting TG Client."
    ls -la /opt/tg2sip
    /opt/tg2sip/tg2sip
else 
    echo "$FILE does not exist. Running GEN_DB."
    ls -la /opt/tg2sip
    /opt/tg2sip/gen_db
fi
