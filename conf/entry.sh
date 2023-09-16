#!/bin/sh

INITALIZED_FILE="/persist-data/initialized"

if [ ! -f $INITALIZED_FILE ]
then
    cd /var/www/html
    # following directories are listed for migration to a new server,
    # they has to be moved to persistent location
    for D in galleries upload plugins themes template-extension local _data
    do
        mv $D /persist-data
        # using relative path rather than absolute "/"
        ln -sf ../../../persist-data/$D .
    done
    echo "Keep this file here or init script will delete all your data!" > $INITALIZED_FILE
fi

apachectl -D FOREGROUND