#!/bin/bash

# Main configuration
# define let's encrypt work directory
CONFIG_DIR="/etc/letsencrypt/renewal"
EXP_LIMIT=30;
ALERTTIME=864000

echo "
################
# Script Start #
################"
# We display date
date

EXIT_CODE="$?"

# domains=$1
# if [ -z "$domains" ] ; then
#         echo "[ERROR] Specified the domains name for the certificates renewal."
#         exit 1;
# fi

# First Take care of Apache2
echo 'Stopping apache2..'
sudo service apache2 stop


echo 'Going to check in general if renewal is needed..'

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
  echo "error starting apache2"
  exit "$EXIT_CODE"
fi

# all done!
echo "Renewal process finished!"
exit "0"


