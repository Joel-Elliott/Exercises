#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use Email::Send::SMTP::Gmail;
use LWP::Simple;
use JSON::MaybeXS ':all';
#use Data::Dumper;

#get username and password from command line #TODO: This could be improved
my ($username, $password) = @ARGV;
my $api = 'INSERT API KEY HERE';  #Paste your API key here.  TODO: Add a prompt if no key provided by user
my $url = "https://api.guildwars2.com/v2/";
my $api_key = "?access_token=$api";

#my $account = get($url."/account".$api_key);
#die ':(' unless defined $account;

#my $characters = get ($url."/characters".$api_key);
my $characterInfoJSON = get ($url."/characters/Vekk%20Bond".$api_key);    #you would change this line to hold your characters name with spaces replaced with %20
die ':(' unless defined $characterInfoJSON;

my %characterInfo = %{decode_json($characterInfoJSON)}; #gets a hash of all character info from the JSON received from the API
my $characterAgeSeconds = $characterInfo{age};
my $days = (gmtime($characterAgeSeconds))[3] - 1; #Days was showing up 1 too high in testing

my $characterAgeFormatted .= sprintf ("%02dd:%02dh:%02dm:%02ds\n",$days,(gmtime($characterAgeSeconds))[2,1,0]); #formats the character's age in a dd:hh:mm:ss format

#open the file and store the contents in a variable. the contents are the time from the last time the script was ran.
my $filename = 'timePlayed.txt';
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  my $previousTime = <$fh>;
  my $previousLocalTime = <$fh>;
close $fh;
#calculate the difference between the time it was ran now and previously
my $timeDifference = $characterAgeSeconds - $previousTime;
my $timeDifferenceFormatted .= sprintf ("%02dh:%02dm:%02ds\n",(gmtime($timeDifference))[2,1,0]); #formats the time difference in a dd:hh:mm:ss format
#save the current time played, previous time played, and timestamp in the file
my $localTime = localtime;
open($fh, '>:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  print $fh "$characterAgeSeconds\n";
  print $fh "$localTime\n";
  print $fh "$previousTime\n";
close $fh;

#build the email object & login to the gmail smtp server through TLS required port 587
my $mail=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com',
                                       -login=>"$username".'@gmail.com',
                                       -pass=>"$password",
                                       -port=>587);
#send the email to self
$mail->send(-to=>"$username".'@gmail.com', -subject=>'GW2 Character Age !', -body=>"You have played this character for $characterAgeFormatted total.\nYou have played for $timeDifferenceFormatted seconds since the last time this script was last ran at $previousLocalTime\n",);

$mail->bye;
