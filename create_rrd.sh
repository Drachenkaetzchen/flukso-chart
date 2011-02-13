#!/usr/bin/env bash

if [ "$#" != "1" ]; then
	echo "Usage: $0 <database>"
	echo
	echo "Creates an empty rrd database for use with flukso data. Initializes the start time to 30 days ago."
	echo
	echo "Example: $0 /var/www/test.rrd"
	exit
fi;

START=`php -r "echo time() - 60*60*24*30;"`
rrdtool create $1 --start $START DS:watt:GAUGE:60:U:U RRA:AVERAGE:0.5:1:3200 RRA:AVERAGE:0.5:6:3200 RRA:AVERAGE:0.5:36:3200 RRA:AVERAGE:0.5:144:3200 RRA:AVERAGE:0.5:1008:3200 RRA:AVERAGE:0.5:4320:3200 RRA:AVERAGE:0.5:52560:3200 RRA:AVERAGE:0.5:525600:3200 RRA:MIN:0.5:1:3200 RRA:MIN:0.5:6:3200 RRA:MIN:0.5:36:3200 RRA:MIN:0.5:144:3200 RRA:MIN:0.5:1008:3200 RRA:MIN:0.5:4320:3200 RRA:MIN:0.5:52560:3200 RRA:MIN:0.5:525600:3200 RRA:MAX:0.5:1:3200 RRA:MAX:0.5:6:3200 RRA:MAX:0.5:36:3200 RRA:MAX:0.5:144:3200 RRA:MAX:0.5:1008:3200 RRA:MAX:0.5:4320:3200 RRA:MAX:0.5:52560:3200 RRA:MAX:0.5:525600:3200
