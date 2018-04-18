#!/bin/bash
echo 'extension=mysqli' >> /etc/php.ini

rm -rf /run/httpd/* /tmp/httpd*
exec /usr/sbin/apachectl -D FOREGROUND
