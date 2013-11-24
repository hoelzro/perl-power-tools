#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use File::Slurp qw(read_file);
use File::Spec;
use File::Temp;
use Template;
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
            if($line =~ /^\s*%/) {
                undef $line;
                next;
            }
            $line =~ s/%.*//;

            # handle my PAUSE directive
            if($line eq 'PAUSE') {
                push @result, $result[-1];
                chomp $result[-2];
                next;
            }

            # handle my DEMO directive
            if($line =~ s/DEMO\K\[(?<demo_name>.*?)\]//) {
                # XXX this should go into a div handout
                # no-op for now; fill in demo gifs later
            }

            $result[-1] .= $line . "\n";
        }
        chomp $result[-1];
    }

    return join("\n", map { "<div class='slide'>\n" . markdown($_) . "\n</div>" } @result);
}

my $template_dir = File::Temp->newdir;

use Data::Printer;
p source_to_slides('pages/regexp-debugger.md');
__DATA__
my $tt = Template->new({
    INCLUDE_PATH => ['.', $template_dir->dirname],
});

foreach my $page (glob('pages/*.md')) {
    my ( undef, undef, $filename ) = File::Spec->splitpath($page);
    my $slides = source_to_slides($filename);
    $tt->process(\$slides, {}, File::Spec->catfile($template_dir->dirname,
        $filename =~ s/[.]md$/.tt/r)) || die $tt->error;
}

$tt->process('index.tt', {}, 'index.html') || die $tt->error;
