#!/bin/sh
cd /home/tmf/xaseco
php aseco.php TMF </dev/null >aseco.log 2>&1 &
echo $!
