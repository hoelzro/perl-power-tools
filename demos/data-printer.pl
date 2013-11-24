#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use DateTime;
use Data::Printer;
use URI;

my $object = {
    count => 17,
    date  => DateTime->now,
    uri   => URI->new('http://hoelz.ro'),
    jobs  => {
        Rob => 'Developer',
    },
};

p $object;
