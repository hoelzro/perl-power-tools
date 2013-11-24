# Regular Expressions

SLIDE

% Who here has ever used a regular expression?

% Does anyone recognize this regex? (It's a regex written by Randal Schwartz for parsing JSON)

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

% Let's return to that earlier question, but with a twist: Who here has ever had a regular expression go wrong?

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

DEMO[regexp-debugger.gif]
