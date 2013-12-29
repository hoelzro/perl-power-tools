# Inspecting Objects (We Need To Go Deeper)

Sometimes we need to go a level deeper into an object; by that, I mean
looking at the actual in-memory structures that the Perl interpreter manages
itself.  Maybe you're writing an XS module and you want to make sure your reference
counts are right; maybe you're fine tuning some code in a hot path and trying to
make sure Perl isn't doing crazy stuff with your data.  No matter what, the following
module will come in handy.

SLIDE

**Devel::Peek**

SLIDE

[Devel::Peek Demo](images/devel-peek.png)

SLIDE

The demo illustrates the fields in a scalar value (or SV), as well as an optimization
that Perl performs called the offset hack.  You can read more about this in the Perl
documentation on its internals.

Devel::Peek isn't just a great debugging tool; playing around with it can give you
some insight into how the Perl interpreter works as well.
