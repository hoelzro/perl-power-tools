package Room {
    use Carp qw(croak);
    use Moose;

    has width => (
        is       => 'rw',
        isa      => 'Int',
        required => 1,
        trigger  => __PACKAGE__->can('_trigger_width'),
    );

    has height => (
        is       => 'rw',
        isa      => 'Int',
        required => 1,
    );

    sub _trigger_width {
        my ( $self, $new, $old ) = @_;

        croak "Bad value" if $new < 0;
    }
}

sub bar {
    my ( $room ) = @_;

    $room->width(-10);
}

sub foo {
    my ( $room ) = @_;
    bar($room);
}

sub main {
    my $room = Room->new(
        width  => 10,
        height => 10,
    );

    foo($room);
}

main();
