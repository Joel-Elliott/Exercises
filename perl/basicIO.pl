#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

my $input = prompt("Write some text: ");

say "You entered: $input";

sub prompt {
  (my $words) = @_;
  say $words;
  my $userInput = <STDIN>;
  chomp $userInput;
  return $userInput;
}
