<?php

if ($_SERVER["argc"] != 3) {
	echo "Usage: ".$_SERVER["argv"][0]." <tmpfile> <rrd-database>";
	exit();
}

$tmpfile = $_SERVER["argv"][2];

$rrdtool_executable = "/usr/bin/rrdtool";
$rrdtool_database = $_SERVER["argv"][1];

$data = file_get_contents($tmpfile);

$json_data = json_decode($data);

foreach ($json_data as $data) {
	$timestamp = $data[0];
	$value = $data[1];

	$cmd = $rrdtool_executable . " update ".$rrdtool_database . " ".$timestamp.":".$value;

	exec($cmd);
}
?>
