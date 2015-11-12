#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use Email::Send::SMTP::Gmail;

my $mail=Email::Send::SMTP::Gmail->new( -smtp=>'smtp.gmail.com',
                                                 -login=>'username@gmail.com',
                                                 -pass=>'password',
                                                 -port=>587);

say "log in successful!";
$mail->send(-to=>'username@gmail.com', -subject=>'This is a test!', -body=>'This email was sent through a Perl script',);

$mail->bye;
