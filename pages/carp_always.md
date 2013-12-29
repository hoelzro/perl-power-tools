# Fun with Stack Traces

SLIDE

Let's say you're stuck in a room with a moose.

PAUSE

![Room with a Moose](images/room_with_a_moose.png)

SLIDE

...and down the line, part of your application throws an exception, leaving you with this wonderfully
helpful error:

   Bad value at accessor Room::width (defined at test.pl line 5) line 13.

SLIDE

How can we make this better?

PAUSE

**Carp::Always**

SLIDE

New output after enabling `Carp::Always`:

    Bad value at test.pl line 21.
      Room::_trigger_width('Room=HASH(0xde9878)', -10, 10) called at accessor Room::width (defined at test.pl line 5) line 13
      Room::width('Room=HASH(0xde9878)', -10) called at test.pl line 28
      main::bar('Room=HASH(0xde9878)') called at test.pl line 33
      main::foo('Room=HASH(0xde9878)') called at test.pl line 42
      main::main() called at test.pl line 21.
      Room::_trigger_width('Room=HASH(0xde9878)', -10, 10) called at accessor Room::width (defined at test.pl line 5) line 13
      Room::width('Room=HASH(0xde9878)', -10) called at test.pl line 28
      main::bar('Room=HASH(0xde9878)') called at test.pl line 33
      main::foo('Room=HASH(0xde9878)') called at test.pl line 42
      main::main() called at test.pl line 46

SLIDE

`Carp::Always` is ridiculously easy to use; you need only `use` it at the beginning of your script.  You don't even need
to alter your program if you don't want to; you can add `-MCarp::Always` to your command line as well.
