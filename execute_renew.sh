#!/bin/bash

# Main configuration
# define let's encrypt work directory
CONFIG_DIR="/etc/letsencrypt/renewal"
EXP_LIMIT=30;

ALERTTIME=864000

EXIT_CODE="$?"

# First Take care of Apache2
sudo service apache2 stop

if [ 0 -ne "$EXIT_CODE" ]
then
	echo  "error stopping apache2"
	exit "$EXIT_CODE"
fi


# update certificates
sudo letsencrypt renew

if [ 0 -ne "$EXIT_CODE" ]
then
  echo "error renewing certificates"
  exit "$EXIT_CODE"
fi

# turn on Apache2
sudo service apache2 start

if [ 0 -ne "$EXIT_CODE" ]
then
  echo "error starting nginx"
  exit "$EXIT_CODE"
fi

# all done!
echo "all done!"
exit "0"


