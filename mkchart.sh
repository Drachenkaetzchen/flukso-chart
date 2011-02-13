#!/usr/bin/env bash

if [ "$#" != "2" ]; then
	echo "Usage: $0 <rrd-database> <output-filename>"
	echo
	echo "Example: $0 test.rrd output.png"
	exit
fi;

DB=$1
OUTPUT=$2

rrdtool graph $OUTPUT -a PNG --width 480 --start -1d \
        DEF:watt=$DB:watt:AVERAGE \
        DEF:wattmin=$DB:watt:MIN \
        DEF:wattmax=$DB:watt:MAX \
        LINE1:watt#FF0000:"watt" \
        LINE1:wattmin#00FF00:"watt min" \
        LINE1:wattmax#0000FF:"watt max" \
        'GPRINT:watt:LAST:last\: %lf' \
        'GPRINT:watt:MIN:min\: %lf' \
        'GPRINT:watt:MAX:max\: %lf' \
        > /dev/null
