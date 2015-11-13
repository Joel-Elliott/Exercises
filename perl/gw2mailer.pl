#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use Email::Send::SMTP::Gmail;
use LWP::Simple;
use JSON::MaybeXS ':all';
#use Data::Dumper;

my ($username, $password) = @ARGV;
my $api = 'INSERT API KEY HERE';
my $url = "https://api.guildwars2.com/v2/";
my $api_key = "?access_token=$api";

my $account = get($url."/account".$api_key);
my $characters = get ($url."/characters".$api_key);
my $characterInfoJSON = get ($url."/characters/Vekk%20Bond".$api_key);

my %characterInfo = %{decode_json($characterInfoJSON)};
my $characterAgeSeconds = $characterInfo{age};
my $days = (gmtime($characterAgeSeconds))[3] - 1;
#print "$days\n";
#
my $characterAgeFormatted .= sprintf ("%02dd:%02dh:%02dm:%02ds\n",$days,(gmtime($characterAgeSeconds))[2,1,0]);

#print "$characterAgeFormatted";
die ':(' unless defined $account;

my $mail=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com',
                                       -login=>"$username".'@gmail.com',
                                       -pass=>"$password",
                                       -port=>587);

$mail->send(-to=>"$username".'@gmail.com', -subject=>'GW2 Character Age !', -body=>"You have played this character for $characterAgeFormatted\n",);

$mail->bye;
