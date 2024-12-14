#!/bin/sh
/usr/local/bin/mysql --host 10.0.0.1 --user=db_mailserver --pass=<PASSWORT> db_mailserver < /usr/local/etc/dspam_purge.sql > /dev/null