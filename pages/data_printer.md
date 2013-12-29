# Inspecting Objects

At work, I do a lot with web services.  Sometimes, I like to dump the result of a web service call to see
exactly what I'm getting from the service.  So how can we dump an arbitrarily-complicated structure to
the console?

SLIDE

* Data::Dumper - Ships with core, does a fine job
PAUSE
* Data::Dumper::Concise - Data::Dumper with some nice options

SLIDE

**Data::Printer**

SLIDE

[Data::Printer Demo](images/data-printer.png)

SLIDE

Note the fancy colors, the contextual information on where the value
is being printed, the object internals, and the method listing for
the blessed references.  All of this can be tweaked when importing
`Data::Printer`, or in a configuration file.  If you look at the demo
source, you can see that dumping something is done with a simple
`p` function; `Data::Printer` makes sure it's quick and easy to
see what you need.  You may also tell `Data::Printer` to print certain
objects specially; for example, if you don't care about the internals
of a `DateTime` object.  Check the documentation for all of the cool
tricks you can do!
