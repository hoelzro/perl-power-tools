# Regular Expressions

As Perl programmers, we often leverage the power of regular expressions...

PAUSE

...but their power and expressiveness can make them easy to abuse and tricky to debug.  Have
a look at this regex:

SLIDE

    qr{

    (?&VALUE) (?{ $_ = $^R->[1] })

    (?(DEFINE)

    (?<OBJECT>
      (?{ [$^R, {}] })
      \{
        (?: (?&KV) # [[$^R, {}], $k, $v]
          (?{ # warn Dumper { obj1 => $^R };
         [$^R->[0][0], {$^R->[1] => $^R->[2]}] })
          (?: , (?&KV) # [[$^R, {...}], $k, $v]
            (?{ # warn Dumper { obj2 => $^R };
           [$^R->[0][0], {%{$^R->[0][1]}, $^R->[1] => $^R->[2]}] })
          )*
        )?
      \}
    )

    (?<KV>
      (?&STRING) # [$^R, "string"]
      : (?&VALUE) # [[$^R, "string"], $value]
      (?{ # warn Dumper { kv => $^R };
         [$^R->[0][0], $^R->[0][1], $^R->[1]] })
    )

    (?<ARRAY>
      (?{ [$^R, []] })
      \[
        (?: (?&VALUE) (?{ [$^R->[0][0], [$^R->[1]]] })
          (?: , (?&VALUE) (?{ # warn Dumper { atwo => $^R };
                 [$^R->[0][0], [@{$^R->[0][1]}, $^R->[1]]] })
          )*
        )?
      \]
    )

    (?<VALUE>
      \s*
      (
          (?&STRING)
        |
          (?&NUMBER)
        |
          (?&OBJECT)
        |
          (?&ARRAY)
        |
        true (?{ [$^R, 1] })
      |
        false (?{ [$^R, 0] })
      |
        null (?{ [$^R, undef] })
      )
      \s*
    )

    (?<STRING>
      (
        "
        (?:
          [^\\"]+
        |
          \\ ["\\/bfnrt]
    #    |
    #      \\ u [0-9a-fA-f]{4}
        )*
        "
      )

      (?{ [$^R, eval $^N] })
    )

    (?<NUMBER>
      (
        -?
        (?: 0 | [1-9]\d* )
        (?: \. \d+ )?
        (?: [eE] [-+]? \d+ )?
      )

      (?{ [$^R, eval $^N] })
    )

    ) }xms;

SLIDE

I didn't even include the whole thing; this is a regex that venerable Perl hacker
Randal Schwartz wrote for parsing JSON.  It's very clever, but if something like this
breaks while you're writing it, you've got a problem.

PAUSE

![Perl Problems](images/perl_problems.png)

SLIDE

So...how do we debug regexes?

PAUSE
  * printf debugging using `(?{...})`
PAUSE
  * Remove pieces constantly and see what's working and what's not
PAUSE
  * Use a debugger

SLIDE

Enter **Regexp::Debugger**.

SLIDE

DEMO (the screen refreshes are a bit annoying, but hopefully the point is illustrated)

<http://showterm.io/74d851d162bf5c93b5bb1>

SLIDE

Take note: `Regexp::Debugger` is lexical.  That means that we can debug certain regular expression
while leaving the rest of the program alone.
