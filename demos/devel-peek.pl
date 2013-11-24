#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use Devel::Peek;

my $greeting = 'Hello, World!';
$greeting    =~ s/Hello/Hi/;

Dump($greeting);
