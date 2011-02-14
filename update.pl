#!/usr/bin/env perl
# vim:ts=4:sw=4:expandtab 

use strict;
use warnings;
use JSON::XS;
use RRDTool::OO;
use LWP::UserAgent;
use Getopt::Long;

my $token;
my $sensor;
my $filename;

my $result = GetOptions(
    "token=s" => \$token,
    "sensor=s" => \$sensor,
    "rrd=s" => \$filename
);

if (!$result || !$token || !$sensor || !$filename) {
    die "Usage: update.pl --token <token> --sensor <sensor> --rrd <database>";
}

my $ua = LWP::UserAgent->new;
$ua->default_header('Accept' => 'application/json');
$ua->default_header('X-Version' => '1.0');
$ua->default_header('X-Token' => $token);
my $response = $ua->get("https://api.mysmartgrid.de/sensor/$sensor?interval=hour&unit=watt");
if (!$response->is_success) {
    die "Error communicating with mysmartgrid: " . $response->status_line;
}

my $rrd = RRDTool::OO->new(file => $filename);
my $last = $rrd->last;
my $json = decode_json($response->decoded_content);
for my $data (@{$json}) {
    next if $data->[0] <= $last;
    next if $data->[1] eq 'nan';
    $rrd->update(time => $data->[0], value => $data->[1]);
}
