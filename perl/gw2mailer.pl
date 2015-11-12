#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use Email::Send::SMTP::Gmail;
use LWP::Simple;

my ($username, $password) = @ARGV;
my $api = 'INSERT API KEY HERE'
my $url = "https://api.guildwars2.com/v2/";
my $api_key = "?access_token=$api";

my $account = get($url."/account".$api_key);
my $characters = get ($url."/characters/".$api_key);
die ':(' unless defined $account;

say $age;
my $mail=Email::Send::SMTP::Gmail->new( -smtp=>'smtp.gmail.com',
                                                 -login=>"$username".'@gmail.com',
                                                 -pass=>"$password",
                                                 -port=>587);

$mail->send(-to=>"$username".'@gmail.com', -subject=>'GW2 Account info!', -body=>"$account \n\n $characters",);

$mail->bye;
