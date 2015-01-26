# Prelude

> Liquid architecture. It's like jazz - you improvise, you work together, you play off each other, you make something, they make something. <br/>
> -- Frank Gehry

Style matters. Elixir has plenty of style but like all languages it can be stifled.
Don't stifle the style.

**NOTE**: From here on out, you get a PR merged, you get added as a collaborator. People who have
PRs merged have been added as collaborators.

# The Elixir Style Guide

This is my attempt at starting a community style guide for Elixir. Please
feel free to make pull requests and contribute. I really want Elixir to
have as vibrant of a community as any language that's been around five
times as long.

If you're looking for other projects to contribute to please see Elixir's wiki
page with [list of projects] or [hex package manager site].

## Table of Contents

* [Source Code Layout](#source-code-layout)
* [Syntax](#syntax)
* [Naming](#naming)
* [Comments](#comments)
    * [Comment Annotations](#comment-annotations)
* [Modules](#modules)
* [Exceptions](#exceptions)
* [Collections](#collections)
* [Strings](#strings)
* [Regular Expressions](#regular-expressions)
* [Metaprogramming](#metaprogramming)
* [Misc](#misc)
* [Tools](#tools)

## Source Code Layout

<!-- TODO: Add crafty quote here -->

* Use two **spaces** per indentation level. No hard tabs.

```Elixir
# not preferred - four spaces
def some_function do
    do_something
end

# preferred
def some_function do
  do_something
end
```

* Use Unix-style line endings. (\*BSD/Solaris/Linux/OSX users are covered by default,
  Windows users have to be extra careful.)


    * If you're using Git you might want to add the following
    configuration setting to protect your project from Windows line
    endings creeping in:

```bash
$ git config --global core.autocrlf true
```

* Use spaces around operators, after commas, colons and semicolons. Do not put spaces around matched pairs like brackets, parenthesis, etc. Whitespace might be (mostly) irrelevant to the Elixir runtime, but its proper use is the key to writing easily readable code.

```Elixir
sum = 1 + 2
{a, b} = {2, 3}
Enum.map(["one", <<"two">>, "three"], fn num -> IO.puts num end)
```

* Use empty lines between `def`s and to break up a function into logical
  paragraphs.

```Elixir
def some_function(some_data) do
  altered_data = Module.function(data)
end

def some_function do
  result
end

def some_other_function do
  another_result
end

def a_longer_function do
  one
  two

  three
  four
end
```

* ...but run different clauses that match for the same function together.

```Elixir
def some_function([]) do
  :ok
end
def some_function([first|rest]) do
  some_function(rest)
end
```

* Use the pipeline operator ( |> ) to chain functions together

```Elixir
# not preferred
String.strip(String.downcase(some_string))

# preferred
some_string |> String.downcase |> String.strip

# Multiline pipelines use a single level of indentation.
some_string
|> String.downcase
|> String.strip
```

While this is the preferred method, take into account that copy pasting multiline pipelines into IEX might result in a syntax error as IEX will evaluate the first line without realizing that the next line has a pipeline.

* Use _bare_ variables in the first part of a function chain

```Elixir
# THE WORST!
# This actually parses as String.strip( "nope" |> String.downcase ).
String.strip "nope" |> String.downcase

# not preferred
String.strip(some_string) |> String.downcase |> String.codepoints

# preferred
some_string |> String.strip |> String.downcase |> String.codepoints
```

* Avoid trailing whitespace.

## Syntax

* Use parentheses when you have arguments, no parentheses when you don't

```Elixir
# not preferred
def some_function arg1, arg2 do
  # body omitted
end

def some_function() do
  # body omitted
end

# preferred
def some_function(arg1, arg2) do
  #body omitted
end

def some_function do
  # body omitted
end
```

* Never use `do:` for multi-line `if/unless`.

```Elixir
# not preferred
if some_condition, do:
  # a line of code
  # another line of code
  # note no end in this block

# preferred
if some_condition do
  # some
  # lines
  # of code
end
```

* Use `do:` for single line `if/unless` statements

```Elixir
# preferred
if some_condition, do: # some_stuff
```


* Never use `unless` with `else`. Rewrite these with the positive case first.

```Elixir
# not preferred
unless success? do
  IO.puts 'failure'
else
  IO.puts 'success'
end

# preferred
if success? do
  IO.puts 'success'
else
  IO.puts 'failure'
end
```

* Never put a space between a function name and the opening parenthesis.

```Elixir
# not preferred
f (3 + 2) + 1

# preferred
f(3 + 2) + 1
```

* Use parentheses in function calls, especially inside a pipeline.

```Elixir
# not preferred
f 3

# preferred
f(3)

# not preferred and parses as f(3 |> g), which is not what you want
f 3 |> g

# preferred
f(3) |> g()
```

* Omit parentheses in macro calls when a do block is passed.

```Elixir
# not preferred
quote(do
  foo
end)

# preferred
quote do
  foo
end
```

* Optionally omit parentheses in function calls (outside a pipeline) when
  the last argument is a function expression.

```Elixir
# preferred
Enum.reduce(1..10, 0, fn x, acc ->
  x + acc
end)

# also preferred
Enum.reduce 1..10, 0, fn x, acc ->
  x + acc
end
```

## Naming

* Use `snake_case` for atoms, functions and variables.

```Elixir
# not preferred
:"some atom"
:SomeAtom
:someAtom

someVar = 5

def someFunction do
  ...
end

def SomeFunction do
 ...
end

# preferred
:some_atom

some_var = 5

def some_function do
  ...
end
```

* Use `CamelCase` for modules.  (Keep acronyms like HTTP,
  RFC, XML uppercase.)

```Elixir
# not preferred
defmodule Somemodule do
  ...
end

defmodule Some_Module do
  ...
end

defmodule SomeXml do
  ...
end

# preferred
defmodule SomeModule do
  ...
end

defmodule SomeXML do
  ...
end
```

* The names of predicate functions (a function that return a boolean value)
  should have a trailing question mark rather than a leading `is_` or similar.

```Elixir
def cool?(var) do
  # checks if var is cool
end
```

## Comments

* Write self-documenting code and ignore the rest of this section. Seriously!
* Use one space between the leading `#` character of the comment and the text
  of the comment.
* Comments longer than a word are capitalized and use punctuation. Use [one
  space](http://en.wikipedia.org/wiki/Sentence_spacing) after periods.

```Elixir
# not preferred
String.upcase(some_string) # Capitalize string.
```

* Keep existing comments up-to-date. An outdated comment is worse than no comment
at all.

* Avoid writing comments to explain bad code. Refactor the code to
  make it self-explanatory. (Do or do not - there is no try. --Yoda)

### Comment Annotations

* Annotations should usually be written on the line immediately above
  the relevant code.
* The annotation keyword is followed by a colon and a space, then a note
  describing the problem.
* If multiple lines are required to describe the problem, subsequent
  lines should be indented two spaces after the `#`.

* In cases where the problem is so obvious that any documentation would
  be redundant, annotations may be left at the end of the offending line
  with no note. This usage should be the exception and not the rule.


* Use `TODO` to note missing features or functionality that should be
  added at a later date.
* Use `FIXME` to note broken code that needs to be fixed.
* Use `OPTIMIZE` to note slow or inefficient code that may cause
  performance problems.
* Use `HACK` to note code smells where questionable coding practices
  were used and should be refactored away.
* Use `REVIEW` to note anything that should be looked at to confirm it
  is working as intended. For example: `REVIEW: Are we sure this is how the
  client does X currently?`
* Use other custom annotation keywords if it feels appropriate, but be
  sure to document them in your project's `README` or similar.

## Modules

* Use one module per file unless the module is only used internally by
  another module (such as a test.)
* Use underscored file names for `CamelCase` module names.

```Elixir
# file is called some_module.ex

defmodule SomeModule do
end
```

* Represent each level of nesting within a module name as a directory.

```Elixir
# file is called parser/core/xml_parser.ex

defmodule Parser.Core.XMLParser do
end
```

## Exceptions

## Collections

## Strings

## Regular Expressions

## Metaprogramming

* Avoid needless metaprogramming.

## Misc

## Tools

# Contributing

It's my hope that this will become a central
hub for community discussion on best
practices in Elixir.
Feel free to open tickets or send pull requests with improvements. Thanks in
advance for your help!

# License

![Creative Commons License](http://i.creativecommons.org/l/by/3.0/88x31.png)
This work is licensed under a [Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/deed.en_US)

# Attribution
The structure of this guide, bits of example code, and many of the initial
points made in this document were borrowed from the
[Ruby community style guide](https://github.com/bbatsov/ruby-style-guide).
A lot of things were applicable to Elixir and allowed me to get
_some_ document out quicker to start the conversation.


# Spread the Word

A community style guide is meaningless
without the community's support.
Please Tweet, star, and let any Elixir
programmer know about this guide so
they can contribute.

[list of projects]: https://github.com/elixir-lang/elixir/wiki/Projects
[hex package manager site]: https://hex.pm/packages
