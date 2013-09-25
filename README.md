# Prelude

> Liquid architecture. It's like jazz - you improvise, you work together, you play off each other, you make something, they make something. <br/>
> -- Frank Gehry

Style matters. Elixir has plenty of style but like all languages it can be stifled.
Don't stifle the style.

This is my attempt at starting a community style guide for Elixir. Please
feel free to make pull requests and contribute. I really want Elixir to
have as vibrant of a community as any language that's been around five
times as long.

If you're looking for other projects to contribute to please see Elixir's
[list of projects](https://github.com/elixir-lang/elixir/wiki/Projects)

If you're coming from Rails you may also want to check out [Chicago Boss](http://www.chicagoboss.org/)
Elixir support isn't complete but it's growing and I'm sure they could use contributors.

# The Elixir Style Guide

I'm loving Elixir and really want to see it get off to a good
start with great documentation and a vibrant community. I'm
borrowing a lot of the organization, several bits of code examples,
and a lot of the text below from the Ruby style in an attempt to
get this out quickly. Additionally, everything I've included is the
opinion of a Junior level programmer who's only been programming for
around a year. _Please_ jump in and fix any nonsense you find and let's
keep a conversation going about Elixir best practices as the language
evolves.

## Table of Contents

* [Source Code Layout](#source-code-layout)
* [Syntax](#syntax)
* [Naming](#naming)
* [Comments](#comments)
    * [Comment Annotations](#comment-annotations)
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
  # bad - four spaces
  def some_method
      do_something
  end

  # good
  def some_method
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

* Use spaces around operators, after commas, colons and semicolons, around `{`
  and before `}`. Whitespace might be (mostly) irrelevant to the Elixir runtime,
  but its proper use is the key to writing easily readable code.

```Elixir
  sum = 1 + 2
  { a, b } = { 2, 3 }
  Enum.map( [1, 2, 3], fn ( num ) -> IO.puts num end
```

* Use empty lines between `def`s and to break up a method into logical
  paragraphs.

```Elixir
  def some_method(some_data)
    altered_data = Module.Function(data)
  end

  def some_method
    result
  end

  def some_other_method
    another_result
  end
```

* ...but run different clauses that match for the same function together.

```Elixir
  def some_method([]) do
    :ok
  end
  def some_method([first|rest]) do
    some_method(rest)
  end
```

* Use the |> operator to chain methods together

```Elixir
  # bad
  String.strip(String.downcase(some_string))

  # good
  some_string |> String.downcase |> String.strip
```

* Avoid trailing whitespace.

## Syntax

* Always `def` with parentheses.

```Elixir
  # bad
  def some_method
    # body omitted
  end

  # good
  def some_method()
    # body omitted
  end

  # bad
  def some_method_with_arguments arg1, arg2
    # body omitted
  end

  # good
  def some_method_with_arguments(arg1, arg2)
    # body omitted
  end
```

* Never use `do:` for multi-line `if/unless`.

```Elixir
  # bad
  if some_condition, do:
    # a line of code
    # another line of code
    # note no end in this block
  
  # good
  if some_condition
    # some
    # lines
    # of code
  end
```

* Use `do:` for single line `if/unless` statements

```Elixir
  # good
  if some_condition, do: # some_stuff
```


* Never use `unless` with `else`. Rewrite these with the positive case first.

```Elixir
  # bad
  unless success?
    IO.puts 'failure'
  else
    IO.puts 'success'
  end

  # good
  if success?
    IO.puts 'success'
  else
    IO.puts 'failure'
  end
```

* Never put a space between a method name and the opening parenthesis.

```Elixir
  # bad
  f (3 + 2) + 1

  # good
  f(3 + 2) + 1
```

* Use parentheses in function calls, especially inside a pipeline.

```Elixir
  # bad
  f 3

  # good
  f(3)

  # bad and parses as f(3 |> g), which is not what you want
  f 3 |> g

  # good
  f(3) |> g()
```

* Omit parentheses in macro calls when a do block is passed.

```Elixir
  # bad
  quote(do
    foo
  end)

  # good
  quote do
    foo
  end
```

* Optionally omit parentheses in function calls (outside a pipeline) when
  the last argument is a function expression.

```Elixir
  # good 
  Enum.reduce(1..10, 0, fn x, acc ->
    x + acc
  end)

  # also good
  Enum.reduce 1..10, 0, fn x, acc ->
    x + acc
  end
```

## Naming

* Use `snake_case` for symbols, methods and variables.

```Elixir
  # bad
  :"some symbol"
  :SomeSymbol
  :someSymbol

  someVar = 5

  def someMethod
    ...
  end

  def SomeMethod
   ...
  end

  # good
  :some_symbol

  def some_method
    ...
  end
```

* Use `CamelCase` for modules.  (Keep acronyms like HTTP,
  RFC, XML uppercase.)

```Elixir
  # bad
  defmodule Somemodule
    ...
  end

  defmodule Some_Module
    ...
  end

  defmodule SomeXml
    ...
  end

  # good
  defmodule SomeModule
    ...
  end

  defmodule SomeXML
    ...
  end
```

* The names of predicate functions (a function that return a boolean value)
  should end in a question mark.

```Elixir
  def is_string?(var)
    # check if var is string     
  end
```

## Comments

* Write self-documenting code and ignore the rest of this section. Seriously!
* Use one space between the leading `#` character of the comment and the text
  of the comment.
* Comments longer than a word are capitalized and use punctuation. Use [one
  space](http://en.wikipedia.org/wiki/Sentence_spacing) after periods.

```Elixir
  # bad
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
