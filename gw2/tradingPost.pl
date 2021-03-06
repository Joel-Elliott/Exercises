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

my $transactionsJSON = get ($url . "/commerce/transactions/current/sells" . $api_key);
die unless defined $transactionsJSON;
my @transactions = @{decode_json($transactionsJSON)};

#print Dumper @transactions;
#place all item_ids from transactions in a list
my @itemIds;
my $numTransactions = @transactions-1;
foreach my $t (0..$numTransactions) {
  push @itemIds, $transactions[$t]{item_id};
}

print Dumper @itemIds;
