#!/usr/bin/env perl

use 5.14.0;
use warnings;

use File::Slurp qw(read_file);
use File::Spec;
use File::Temp;
use Template;
use Text::Markdown qw(markdown);
use XML::XPath;

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

    my @html = map { markdown($_) } @result;

    my $section = XML::XPath->new(xml => $html[0])->find('h1[1]');

    return join("\n",
        "<div class='slide'>\n$html[0]\n</div>",
        map { "<div class='slide'><h1>$section</h1>\n$_\n</div>" } @html);
}

my $template_dir = File::Temp->newdir;

my $tt = Template->new({
    INCLUDE_PATH => ['.', $template_dir->dirname],
});

foreach my $page (glob('pages/*.md')) {
    my ( undef, undef, $filename ) = File::Spec->splitpath($page);
    my $slides = source_to_slides($page);
    $tt->process(\$slides, {}, File::Spec->catfile($template_dir->dirname,
        $filename =~ s/[.]md$/.tt/r)) || die $tt->error;
}

$tt->process('index.tt', {}, 'index.html') || die $tt->error;
