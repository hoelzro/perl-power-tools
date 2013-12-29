# Getting Faster Feedback

Sometimes, when I want to test some Perl code, I create a file named
`test.pl`, add some code, run it, and continue this cycle until I have
what I need.  However, sometimes you want to reduce the time in between
this writing code/seeing output cycle.  Maybe you're calling a web service and
want to play with the results without exceeding the API limit.  Maybe you've
got some results from a database that took a while to get and you'd like to do
something with them before finalizing your code.  Other languages have the
concept of a REPL (a read-eval-print loop); wouldn't it be nice if Perl had one?

PAUSE

It does!

SLIDE

**Devel::REPL** (and its sibling **Reply**)

SLIDE

`Devel::REPL` has been around a little longer than `Reply`, so there are a few
more plugins for it.  I recommend trying both and seeing which one you like
better.

SLIDE

[Devel::REPL Demo](http://showterm.io/39cc898a139ee33e9ad50)

SLIDE

You may have noticed values being printed using `Data::Printer`; that's because I use a plugin
to enable that.  `Devel::REPL` has a lot of useful plugins; I suggest browsing CPAN and seeing
what's out there!  Or better yet, write your own ;)
