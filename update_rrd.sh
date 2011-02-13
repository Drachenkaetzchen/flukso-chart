#!/usr/bin/env bash
TMP=/tmp/flukso.dat

if [ "$#" != "3" ]; then
	echo "Usage: $0 <token> <sensor> <database>"
	echo
	echo "<token> is the token which is can be found in the 'sensors' section of the mysmartgrid.net site. Note that you need to combine both rows to a single string."
	echo "<sensor> is the sensor ID which can be found on the flukso itself or in the 'sensors' section of the mysmartgrid.net site. You also need to combine both lines."
	echo "<database> is the RRD database to import to"
	echo
	echo "This script stores temporary data to /tmp/flukso.dat"
	exit
fi;

curl -k -X GET \
-o $TMP \
-H "Accept: application/json" \
-H "X-Version: 1.0" \
-H "X-Token: $1" \
"https://api.mysmartgrid.de/sensor/$2?interval=hour&unit=watt"
php import_data.php $3 $TMP
