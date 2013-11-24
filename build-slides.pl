#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use File::Slurp qw(read_file);
use Text::Markdown qw(markdown);

sub source_to_slides {
    my ( $filename ) = @_;

    my $contents = read_file($filename);

    my @result;
    my @slides = split /\n\s*?SLIDE\s*?\n/, $contents;

    foreach my $slide (@slides) {
        my @lines = split /\n/, $slide;

        push @result, '';

        foreach my $line (@lines) {
            # strip comments
            $line =~ s/%.*//;

            if($line =~ /^\s*$/) {
                undef $line;
                next;
            }

            # handle my PAUSE directive
            if($line eq 'PAUSE') {
                push @result, $result[-1];
                chomp $result[-2];
                next;
            }

            # handle my DEMO directive
            if($line =~ s/DEMO\K\[(?<demo_name>.*?)\]//) {
                # no-op for now; fill in demo gifs later
            }

            $result[-1] .= $line . "\n";
        }
        chomp $result[-1];
    }

    return @result;
}

use Data::Printer;
p [ source_to_slides('regexp-debugger.md') ];
