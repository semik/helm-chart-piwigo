#!/bin/sh

INITALIZED_FILE="/var/www/html/local/config/docker-initialized"

if [ ! -f $INITALIZED_FILE ]
then
    cd /var/www/html
    ls -la
    # The following directories are listed for migration to a new server,
    # they has to be moved to persistent location. https://piwigo.org/guides/update/manual
    #
    # At first I tried to move all listed into /persist-data and make symlinks
    # in original place, but Piwigo during initialization removes links and...

    for D in galleries upload plugins themes template-extension local _data
    do
        cp -rv /piwigo-init-data/$D/* $D/
        chown www-data:www-data -R $D
        find $D -type f -exec chmod 644 {} \;
        find $D -type d -exec chmod 755 {} \;
    done
    echo "Keep this file here or init script will delete all your data!" > $INITALIZED_FILE
fi

apachectl -D FOREGROUND