#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

#use Regexp::Debugger;

my $get_extension = qr/[.](?<extension>.*)$/;
my $filename      = 'perl.tar.gz';

if($filename =~ /$get_extension/) {
    say $+{'extension'};
    say 'Should be .gz!';
} else {
    say 'no match';
}
