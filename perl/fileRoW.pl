#!/usr/bin/perl
use 5.010;
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
Getopt::Long::Configure qw(gnu_getopt);

my $read;
my $write;
my $overwrite;
my $help;

GetOptions(
    'read|r=s' => \$read,
    'write|w=s' => \$write,
    'overwrite|o' => \$overwrite,
    'help|h' => \$help,
) or die "--help or -h for help";

if (defined $read) {
  open(my $fh, '<:encoding(UTF-8)', $read) or die "Could not open file '$read' $!";
  while(my $row = <$fh>) {
    chomp $row;
    say "$row";
  }
}

if ($write && $overwrite) {
  open(my $fh, '>:encoding(UTF-8)', $write) or die "Could not open file '$write' $!";
  my $input = prompt("Enter text to overwrite the file '$write'");
  say $fh "$input";
  close $fh;
} elsif ($write && !$overwrite) {
  open(my $fh, '>>:encoding(UTF-8)', $write) or die "Could not open file '$write' $!";
  my $input = prompt("Enter text to append to the file '$write'");
  say $fh "$input";
  close $fh;
}

if (defined $help) {
  my $helpMessage = <<"END_MESSAGE";
  Usage: --read [FILENAME]
         --write [FILENAME]
         --write [FILENAME] --overwrite
         --help
END_MESSAGE
  say "$helpMessage";
}

sub prompt {
  (my $words) = @_;
  say $words;
  my $userInput = <STDIN>;
  chomp $userInput;
  return $userInput;
}
