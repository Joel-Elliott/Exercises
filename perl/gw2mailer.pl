#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use Email::Send::SMTP::Gmail;
use LWP::Simple;

my $url = "https://api.guildwars2.com/v2/";
my $api_key = "?access_token=INSERT API KEY HERE";

my $content = get($url."/account".$api_key);
die ':(' unless defined $content;

#say $content;

my $mail=Email::Send::SMTP::Gmail->new( -smtp=>'smtp.gmail.com',
                                                 -login=>'username@gmail.com',
                                                 -pass=>'password',
                                                 -port=>587);

$mail->send(-to=>'username@gmail.com', -subject=>'GW2 Account info!', -body=>"$content",);

$mail->bye;
