#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use DBI;

my $dbfile = 'dev.db';

my $dsn = "dbi:SQLite:dbname=$dbfile";
my $username = "";
my $password = "";
#initialize db handle
my $dbh = DBI->connect($dsn,$username,$password, {
  PrintError  => 0,
  RaiseError => 1,
  AutoCommit => 1,
  FetchHashKeyName => 'NAME_lc',
});

#create a table by writing SQL in a here document
my $sql = <<'__END__';
CREATE TABLE people (
  id    INTEGER PRIMARY KEY,
  fname VARCHAR(100),
  lname VARCHAR(100),
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(20)
)
__END__

#insert values into table people
$dbh->do($sql);
my $fname = 'Foo';
my $lname = 'Bar';
my $email = 'Foo@bar.com';
$dbh->do('INSERT INTO people (fname, lname, email) VALUES (?, ?, ?)',
  undef,
  $fname, $lname, $email);

my $pass = 'Secret';
my $id = 1;
#update password for user with corresponding id
$dbh->do('UPDATE people SET password = ? WHERE id = ?',
  undef,
  $pass,
  $id);

#select statement
$sql = 'SELECT fname, lname FROM people WHERE id >= ? AND id < ?';
my $sth = $dbh->prepare($sql);

#this returns the row as an array
$sth->execute(1,10);
while (my @row = $sth->fetchrow_array) {
  print "fname: $row[0] lname: $row[1]\n";
}

#this returns the row as a hash
$sth->execute(1,10);
while (my $row = $sth->fetchrow_hashref) {
  print "fname: $row->{fname} lname: $row->{lname}\n";
}


$dbh->disconnect;
