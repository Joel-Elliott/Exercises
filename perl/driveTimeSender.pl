#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use Email::Send::SMTP::Gmail;
use LWP::Simple;
use JSON::MaybeXS ':all';
use Data::Dumper;

#import environmental variables
my $username = $ENV{'GU'};
my $password = $ENV{'GP'};
my $origin = $ENV{'HA'};
my $destination = $ENV{'WA'};
my $key = $ENV{'GMAPSAPIKEY'};

my $baseUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json?';
my $params = '&departure_time=now';
my $url = $baseUrl . 'origins=' . $origin . '&destinations=' . $destination . $params . '&key=' . $key;
#say $url;
my $contentJSON = get($url);
die ':(' unless defined $contentJSON;

my %content = %{decode_json($contentJSON)};

#print Dumper %content;
my $timeToWorkAverage = $content{rows}[0]{elements}[0]{duration}{text};
my $timeToWorkNow = $content{rows}[0]{elements}[0]{duration_in_traffic}{text};
my $distanceToWork = $content{rows}[0]{elements}[0]{distance}{text};

#build the email object & login to the gmail smtp server through TLS required port 587
my $mail=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com',
                                       -login=>"$username".'@gmail.com',
                                       -pass=>"$password",
                                       -port=>587);
#send the email to self
$mail->send(-to=>"$username".'@gmail.com', -subject=>"It will take $timeToWorkNow to get to work today", -body=>"Your origin: $origin\nYour destination: $destination\nAverage drive time: $timeToWorkAverage\nToday's drive time: $timeToWorkNow\nDistance: $distanceToWork",);

$mail->bye;
