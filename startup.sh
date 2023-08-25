#!/bin/bash

cd /opt/tg2sip
ls -la /opt/tg2sip

FILE=/opt/tg2sip/db.sqlite
if [ -f "$FILE" ]; then
    echo "$FILE exists. Starting TG Client."
    /opt/tg2sip/tg2sip
else 
    echo "$FILE does not exist. Running user ping."
    ping 8.8.8.8
fi
