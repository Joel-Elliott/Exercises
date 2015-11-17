#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use Email::Send::SMTP::Gmail;
use LWP::Simple;
use JSON::MaybeXS ':all';
use Data::Dumper;

#get username, password & api key from environmental variables
my $username = $ENV{'GU'};
my $password = $ENV{'GP'};
my $api = $ENV{'GW2APIKEY'};  #TODO: Something if undef

my $url = "https://api.guildwars2.com/v2/";
my $api_key = "?access_token=$api";

my $listingsJSON = get ($url . "/commerce/listings" . $api_key);
die unless defined $listingsJSON;
my %listings = %{decode_json($listingsJSON)};

print Dumper \%listings;
