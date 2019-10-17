# [The Elixir Style Guide][Elixir Style Guide]

## Table of Contents

* __[Prelude](#prelude)__
* __[About](#about)__
* __[Formatting](#formatting)__
  * [Whitespace](#whitespace)
  * [Indentation](#indentation)
  * [Parentheses](#parentheses)
  * [Syntax](#syntax)
* __[The Guide](#the-guide)__
  * [Expressions](#expressions)
  * [Naming](#naming)
  * [Comments](#comments)
    * [Comment Annotations](#comment-annotations)
  * [Modules](#modules)
  * [Documentation](#documentation)
  * [Typespecs](#typespecs)
  * [Structs](#structs)
  * [Exceptions](#exceptions)
  * [Collections](#collections)
  * [Strings](#strings)
  * _Regular Expressions_
  * [Metaprogramming](#metaprogramming)
  * [Testing](#testing)
* __[Resources](#resources)__
  * [Alternative Style Guides](#alternative-style-guides)
  * [Tools](#tools)
* __[Getting Involved](#getting-involved)__
  * [Contributing](#contributing)
  * [Spread the Word](#spread-the-word)
* __[Copying](#copying)__
  * [License](#license)
  * [Attribution](#attribution)

## Prelude

> Liquid architecture. It's like jazz — you improvise, you work together, you
> play off each other, you make something, they make something.
>
> —Frank Gehry

Style matters.
[Elixir] has plenty of style but like all languages it can be stifled.
Don't stifle the style.

## About

This is community style guide for the [Elixir programming language][Elixir].
Please feel free to make pull requests and suggestions, and be a part of
Elixir's vibrant community.

If you're looking for other projects to contribute to please see the
[Hex package manager site][Hex].

<a name="translations"></a>
Translations of the guide are available in the following languages:

* [Chinese Simplified]
* [Chinese Traditional]
* [French]
* [Japanese]
* [Korean]
* [Portuguese]
* [Spanish]

## Formatting

Elixir v1.6 introduced a [Code Formatter] and [Mix format] task.
The formatter should be preferred for all new projects and source code.

The rules in this section are applied automatically by the code formatter, but
are provided here as examples of the preferred style.

### Whitespace

* <a name="trailing-whitespace"></a>
  Avoid trailing whitespace.
  <sup>[[link](#trailing-whitespace)]</sup>

* <a name="newline-eof"></a>
  End each file with a newline.
  <sup>[[link](#newline-eof)]</sup>

* <a name="line-endings"></a>
  Use Unix-style line endings (\*BSD/Solaris/Linux/OSX users are covered by
  default, Windows users have to be extra careful).
  <sup>[[link](#line-endings)]</sup>

* <a name="autocrlf"></a>
  If you're using Git you might want to add the following configuration
  setting to protect your project from Windows line endings creeping in:
  <sup>[[link](#autocrlf)]</sup>

  ```sh
  git config --global core.autocrlf true
  ```

* <a name="line-length"></a>
  Limit lines to 98 characters.
  Otherwise, set the `:line_length` option in your `.formatter.exs` file.
  <sup>[[link](#line-length)]</sup>

* <a name="spaces"></a>
  Use spaces around operators, after commas, colons and semicolons.
  Do not put spaces around matched pairs like brackets, parentheses, etc.
  Whitespace might be (mostly) irrelevant to the Elixir runtime, but its proper
  use is the key to writing easily readable code.
  <sup>[[link](#spaces)]</sup>

  ```elixir
  sum = 1 + 2
  {a, b} = {2, 3}
  [first | rest] = [1, 2, 3]
  Enum.map(["one", <<"two">>, "three"], fn num -> IO.puts(num) end)
  ```

* <a name="no-spaces"></a>
  Do not use spaces after non-word operators that only take one argument; or
  around the range operator.
  <sup>[[link](#no-spaces)]</sup>

  ```elixir
  0 - 1 == -1
  ^pinned = some_func()
  5 in 1..10
  ```

* <a name="def-spacing"></a>
  Use blank lines between `def`s to break up a function into logical
  paragraphs.
  <sup>[[link](#def-spacing)]</sup>

  ```elixir
  def some_function(some_data) do
    some_data |> other_function() |> List.first()
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

* <a name="defmodule-spacing"></a>
  Don't put a blank line after `defmodule`.
  <sup>[[link](#defmodule-spacing)]</sup>

* <a name="long-dos"></a>
  If the function head and `do:` clause are too long to fit on the same line, put
  `do:` on a new line, indented one level more than the previous line.
  <sup>[[link](#long-dos)]</sup>

  ```elixir
  def some_function([:foo, :bar, :baz] = args),
    do: Enum.map(args, fn arg -> arg <> " is on a very long line!" end)
  ```

  When the `do:` clause starts on its own line, treat it as a multiline
  function by separating it with blank lines.

  ```elixir
  # not preferred
  def some_function([]), do: :empty
  def some_function(_),
    do: :very_long_line_here

  # preferred
  def some_function([]), do: :empty

  def some_function(_),
    do: :very_long_line_here
  ```

* <a name="add-blank-line-after-multiline-assignment"></a>
  Add a blank line after a multiline assignment as a
  visual cue that the assignment is 'over'.
  <sup>[[link](#add-blank-line-after-multiline-assignment)]</sup>

  ```elixir
  # not preferred
  some_string =
    "Hello"
    |> String.downcase()
    |> String.trim()
  another_string <> some_string

  # preferred
  some_string =
    "Hello"
    |> String.downcase()
    |> String.trim()

  another_string <> some_string
  ```

  ```elixir
  # also not preferred
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end
  String.downcase(something)

  # preferred
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end

  String.downcase(something)
  ```

* <a name="multiline-enums"></a>
  If a list, map, or struct spans multiple lines, put each element, as well as
  the opening and closing brackets, on its own line.
  Indent each element one level, but not the brackets.
  <sup>[[link](#multiline-enums)]</sup>

  ```elixir
  # not preferred
  [:first_item, :second_item, :next_item,
  :final_item]

  # preferred
  [
    :first_item,
    :second_item,
    :next_item,
    :final_item
  ]
  ```

* <a name="multiline-list-assign"></a>
  When assigning a list, map, or struct, keep the opening bracket on the same
  line as the assignment.
  <sup>[[link](#multiline-list-assign)]</sup>

  ```elixir
  # not preferred
  list =
  [
    :first_item,
    :second_item
  ]

  # preferred
  list = [
    :first_item,
    :second_item
  ]
  ```

* <a name="multiline-case-clauses"></a>
  When `case` or `cond` clauses span multiple lines, separate each clause with a
  blank line.
  <sup>[[link](#multiline-case-clauses)]</sup>

  ```elixir
  # not preferred
  case arg do
    true ->
      :ok
    false ->
      :error
  end

  # preferred
  case arg do
    true ->
      :ok

    false ->
      :error
  end
  ```

* <a name="comments-above-line"></a>
  Place comments above the line they comment on.
  <sup>[[link](#comments-above-line)]</sup>

  ```elixir
  String.first(some_string) # not preferred

  # preferred
  String.first(some_string)
  ```

* <a name="comment-leading-spaces"></a>
  Use one space between the leading `#` character of the comment and the text of
  the comment.
  <sup>[[link](#comment-leading-spaces)]</sup>

  ```elixir
  #not preferred
  String.first(some_string)

  # preferred
  String.first(some_string)
  ```

### Indentation

* <a name="with-clauses"></a>
  Indent and align successive `with` clauses.
  Put the `do:` argument on a new line, aligned with the previous clauses.
  <sup>[[link](#with-clauses)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, my_var} <- fetch(opts, :my_var),
       do: {:ok, foo, my_var}
  ```

* <a name="with-else"></a>
  If the `with` expression has a `do` block with more than one line, or has an
  `else` option, use multiline syntax.
  <sup>[[link](#with-else)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, my_var} <- fetch(opts, :my_var) do
    {:ok, foo, my_var}
  else
    :error ->
      {:error, :bad_arg}
  end
  ```

### Parentheses

* <a name="parentheses-pipe-operator"></a>
  Use parentheses for one-arity functions when using the pipe operator (`|>`).
  <sup>[[link](#parentheses-pipe-operator)]</sup>

  ```elixir
  # not preferred
  some_string |> String.downcase |> String.trim

  # preferred
  some_string |> String.downcase() |> String.trim()
  ```

* <a name="function-names-with-parentheses"></a>
  Never put a space between a function name and the opening parenthesis.
  <sup>[[link](#function-names-with-parentheses)]</sup>

  ```elixir
  # not preferred
  f (3 + 2)

  # preferred
  f(3 + 2)
  ```

* <a name="function-calls-and-parentheses"></a>
  Use parentheses in function calls, especially inside a pipeline.
  <sup>[[link](#function-calls-and-parentheses)]</sup>

  ```elixir
  # not preferred
  f 3

  # preferred
  f(3)

  # not preferred and parses as rem(2, (3 |> g)), which is not what you want.
  2 |> rem 3 |> g

  # preferred
  2 |> rem(3) |> g
  ```

* <a name="keyword-list-brackets"></a>
  Omit square brackets from keyword lists whenever they are optional.
  <sup>[[link](#keyword-list-brackets)]</sup>

  ```elixir
  # not preferred
  some_function(foo, bar, [a: "baz", b: "qux"])

  # preferred
  some_function(foo, bar, a: "baz", b: "qux")
  ```

## The Guide

The rules in this section may not be applied by the code formatter, but they are
generally preferred practice.

### Expressions

* <a name="single-line-defs"></a>
  Run single-line `def`s that match for the same function together, but separate
  multiline `def`s with a blank line.
  <sup>[[link](#single-line-defs)]</sup>

  ```elixir
  def some_function(nil), do: {:error, "No Value"}
  def some_function([]), do: :ok

  def some_function([first | rest]) do
    some_function(rest)
  end
  ```

* <a name="multiple-function-defs"></a>
  If you have more than one multiline `def`, do not use single-line `def`s.
  <sup>[[link](#multiple-function-defs)]</sup>

  ```elixir
  def some_function(nil) do
    {:error, "No Value"}
  end

  def some_function([]) do
    :ok
  end

  def some_function([first | rest]) do
    some_function(rest)
  end

  def some_function([first | rest], opts) do
    some_function(rest, opts)
  end
  ```

* <a name="pipe-operator"></a>
  Use the pipe operator to chain functions together.
  <sup>[[link](#pipe-operator)]</sup>

  ```elixir
  # not preferred
  String.trim(String.downcase(some_string))

  # preferred
  some_string |> String.downcase() |> String.trim()

  # Multiline pipelines are not further indented
  some_string
  |> String.downcase()
  |> String.trim()

  # Multiline pipelines on the right side of a pattern match
  # should be indented on a new line
  sanitized_string =
    some_string
    |> String.downcase()
    |> String.trim()
  ```

  While this is the preferred method, take into account that copy-pasting
  multiline pipelines into IEx might result in a syntax error, as IEx will
  evaluate the first line without realizing that the next line has a pipeline.
  To avoid this, you can wrap the pasted code in parentheses.

* <a name="avoid-single-pipelines"></a>
  Avoid using the pipe operator just once.
  <sup>[[link](#avoid-single-pipelines)]</sup>

  ```elixir
  # not preferred
  some_string |> String.downcase()

  # preferred
  String.downcase(some_string)
  ```

* <a name="bare-variables"></a>
  Use _bare_ variables in the first part of a function chain.
  <sup>[[link](#bare-variables)]</sup>

  ```elixir
  # not preferred
  String.trim(some_string) |> String.downcase() |> String.codepoints()

  # preferred
  some_string |> String.trim() |> String.downcase() |> String.codepoints()
  ```

* <a name="fun-def-parentheses"></a>
  Use parentheses when a `def` has arguments, and omit them when it doesn't.
  <sup>[[link](#fun-def-parentheses)]</sup>

  ```elixir
  # not preferred
  def some_function arg1, arg2 do
    # body omitted
  end

  def some_function() do
    # body omitted
  end

  # preferred
  def some_function(arg1, arg2) do
    # body omitted
  end

  def some_function do
    # body omitted
  end
  ```

* <a name="do-with-single-line-if-unless"></a>
  Use `do:` for single line `if/unless` statements.
  <sup>[[link](#do-with-single-line-if-unless)]</sup>

  ```elixir
  # preferred
  if some_condition, do: # some_stuff
  ```

* <a name="unless-with-else"></a>
  Never use `unless` with `else`.
  Rewrite these with the positive case first.
  <sup>[[link](#unless-with-else)]</sup>

  ```elixir
  # not preferred
  unless success do
    IO.puts('failure')
  else
    IO.puts('success')
  end

  # preferred
  if success do
    IO.puts('success')
  else
    IO.puts('failure')
  end
  ```

* <a name="true-as-last-condition"></a>
  Use `true` as the last condition of the `cond` special form when you need a
  clause that always matches.
  <sup>[[link](#true-as-last-condition)]</sup>

  ```elixir
  # not preferred
  cond do
    1 + 2 == 5 ->
      "Nope"

    1 + 3 == 5 ->
      "Uh, uh"

    :else ->
      "OK"
  end

  # preferred
  cond do
    1 + 2 == 5 ->
      "Nope"

    1 + 3 == 5 ->
      "Uh, uh"

    true ->
      "OK"
  end
  ```

* <a name="parentheses-and-functions-with-zero-arity"></a>
  Use parentheses for calls to functions with zero arity, so they can be
  distinguished from variables.
  Starting in Elixir 1.4, the compiler will warn you about
  locations where this ambiguity exists.
  <sup>[[link](#parentheses-and-functions-with-zero-arity)]</sup>

  ```elixir
  defp do_stuff, do: ...

  # not preferred
  def my_func do
    # is this a variable or a function call?
    do_stuff
  end

  # preferred
  def my_func do
    # this is clearly a function call
    do_stuff()
  end
  ```

### Naming

* <a name="snake-case"></a>
  Use `snake_case` for atoms, functions and variables.
  <sup>[[link](#snake-case)]</sup>

  ```elixir
  # not preferred
  :"some atom"
  :SomeAtom
  :someAtom

  someVar = 5

  def someFunction do
    ...
  end

  # preferred
  :some_atom

  some_var = 5

  def some_function do
    ...
  end
  ```

* <a name="camel-case"></a>
  Use `CamelCase` for modules (keep acronyms like HTTP, RFC, XML uppercase).
  <sup>[[link](#camel-case)]</sup>

  ```elixir
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

* <a name="predicate-macro-names-with-guards"></a>
  The name of macros suitable for use in guard expressions should be prefixed
  with `is_`.
  For a list of allowed expressions, see the [Guard][Guard Expressions] docs.
  <sup>[[link](#predicate-macro-names-with-guards)]</sup>

  ```elixir
  defguard is_cool(var) when var == "cool"
  defguardp is_very_cool(var) when var == "very cool"
  ```

* <a name="predicate-macro-names-no-guards"></a>
  The names of predicate functions _that cannot be used within guards_ should
  have a trailing question mark (`?`) rather than the `is_` (or similar) prefix.
  <sup>[[link](#predicate-macro-names-no-guards)]</sup>

  ```elixir
  def cool?(var) do
    # Complex check if var is cool not possible in a pure function.
  end
  ```

* <a name="private-functions-with-same-name-as-public"></a>
  Private functions with the same name as public functions should start with
  `do_`.
  <sup>[[link](#private-functions-with-same-name-as-public)]</sup>

  ```elixir
  def sum(list), do: do_sum(list, 0)

  # private functions
  defp do_sum([], total), do: total
  defp do_sum([head | tail], total), do: do_sum(tail, head + total)
  ```

### Comments

* <a name="expressive-code"></a>
  Write expressive code and try to convey your program's intention through
  control-flow, structure and naming.
  <sup>[[link](#expressive-code)]</sup>

* <a name="comment-grammar"></a>
  Comments longer than a word are capitalized, and sentences use punctuation.
  Use [one space][Sentence Spacing] after periods.
  <sup>[[link](#comment-grammar)]</sup>

  ```elixir
  # not preferred
  # these lowercase comments are missing punctuation

  # preferred
  # Capitalization example
  # Use punctuation for complete sentences.
  ```

* <a name="comment-line-length"></a>
  Limit comment lines to 100 characters.
  <sup>[[link](#comment-line-length)]</sup>

#### Comment Annotations

* <a name="annotations"></a>
  Annotations should usually be written on the line immediately above the
  relevant code.
  <sup>[[link](#annotations)]</sup>

* <a name="annotation-keyword"></a>
  The annotation keyword is uppercase, and is followed by a colon and a space,
  then a note describing the problem.
  <sup>[[link](#annotation-keyword)]</sup>

  ```elixir
  # TODO: Deprecate in v1.5.
  def some_function(arg), do: {:ok, arg}
  ```

* <a name="exceptions-to-annotations"></a>
  In cases where the problem is so obvious that any documentation would be
  redundant, annotations may be left with no note.
  This usage should be the exception and not the rule.
  <sup>[[link](#exceptions-to-annotations)]</sup>

  ```elixir
  start_task()

  # FIXME
  Process.sleep(5000)
  ```

* <a name="todo-notes"></a>
  Use `TODO` to note missing features or functionality that should be added at a
  later date.
  <sup>[[link](#todo-notes)]</sup>

* <a name="fixme-notes"></a>
  Use `FIXME` to note broken code that needs to be fixed.
  <sup>[[link](#fixme-notes)]</sup>

* <a name="optimize-notes"></a>
  Use `OPTIMIZE` to note slow or inefficient code that may cause performance
  problems.
  <sup>[[link](#optimize-notes)]</sup>

* <a name="hack-notes"></a>
  Use `HACK` to note code smells where questionable coding practices were used
  and should be refactored away.
  <sup>[[link](#hack-notes)]</sup>

* <a name="review-notes"></a>
  Use `REVIEW` to note anything that should be looked at to confirm it is
  working as intended.
  For example: `REVIEW: Are we sure this is how the client does X currently?`
  <sup>[[link](#review-notes)]</sup>

* <a name="custom-keywords"></a>
  Use other custom annotation keywords if it feels appropriate, but be sure to
  document them in your project's `README` or similar.
  <sup>[[link](#custom-keywords)]</sup>

### Modules

* <a name="one-module-per-file"></a>
  Use one module per file unless the module is only used internally by another
  module (such as a test).
  <sup>[[link](#one-module-per-file)]</sup>

* <a name="underscored-filenames"></a>
  Use `snake_case` file names for `CamelCase` module names.
  <sup>[[link](#underscored-filenames)]</sup>

  ```elixir
  # file is called some_module.ex

  defmodule SomeModule do
  end
  ```

* <a name="module-name-nesting"></a>
  Represent each level of nesting within a module name as a directory.
  <sup>[[link](#module-name-nesting)]</sup>

  ```elixir
  # file is called parser/core/xml_parser.ex

  defmodule Parser.Core.XMLParser do
  end
  ```

* <a name="module-attribute-ordering"></a>
  List module attributes and directives in the following order:
  <sup>[[link](#module-attribute-ordering)]</sup>

  1. `@moduledoc`
  1. `@behaviour`
  1. `use`
  1. `import`
  1. `alias`
  1. `require`
  1. `@module_attribute`
  1. `defstruct`
  1. `@type`
  1. `@callback`
  1. `@macrocallback`
  1. `@optional_callbacks`

  Add a blank line between each grouping, and sort the terms (like module names)
  alphabetically.
  Here's an overall example of how you should order things in your modules:

  ```elixir
  defmodule MyModule do
    @moduledoc """
    An example module
    """

    @behaviour MyBehaviour

    use GenServer

    import Something
    import SomethingElse

    alias My.Long.Module.Name
    alias My.Other.Module.Example

    require Integer

    @module_attribute :foo
    @other_attribute 100

    defstruct [:name, params: []]

    @type params :: [{binary, binary}]

    @callback some_function(term) :: :ok | {:error, term}

    @macrocallback macro_name(term) :: Macro.t()

    @optional_callbacks macro_name: 1

    ...
  end
  ```

* <a name="module-pseudo-variable"></a>
  Use the `__MODULE__` pseudo variable when a module refers to itself. This
  avoids having to update any self-references when the module name changes.
  <sup>[[link](#module-pseudo-variable)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    defstruct [:name]

    def name(%__MODULE__{name: name}), do: name
  end
  ```

* <a name="alias-self-referencing-modules"></a>
  If you want a prettier name for a module self-reference, set up an alias.
  <sup>[[link](#alias-self-referencing-modules)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    alias __MODULE__, as: SomeModule

    defstruct [:name]

    def name(%SomeModule{name: name}), do: name
  end
  ```

* <a name="repetitive-module-names"></a>
  Avoid repeating fragments in module names and namespaces.
  This improves overall readability and
  eliminates [ambiguous aliases][Conflicting Aliases].
  <sup>[[link](#repetitive-module-names)]</sup>

  ```elixir
  # not preferred
  defmodule Todo.Todo do
    ...
  end

  # preferred
  defmodule Todo.Item do
    ...
  end
  ```

### Documentation

Documentation in Elixir (when read either in `iex` with `h` or generated with
[ExDoc]) uses the [Module Attributes] `@moduledoc` and `@doc`.

* <a name="moduledocs"></a>
  Always include a `@moduledoc` attribute in the line right after `defmodule` in
  your module.
  <sup>[[link](#moduledocs)]</sup>

  ```elixir
  # not preferred

  defmodule AnotherModule do
    use SomeModule

    @moduledoc """
    About the module
    """
    ...
  end

  # preferred

  defmodule AThirdModule do
    @moduledoc """
    About the module
    """

    use SomeModule
    ...
  end
  ```

* <a name="moduledoc-false"></a>
  Use `@moduledoc false` if you do not intend on documenting the module.
  <sup>[[link](#moduledoc-false)]</sup>

  ```elixir
  defmodule SomeModule do
    @moduledoc false
    ...
  end
  ```

* <a name="moduledoc-spacing"></a>
  Separate code after the `@moduledoc` with a blank line.
  <sup>[[link](#moduledoc-spacing)]</sup>

  ```elixir
  # not preferred
  defmodule SomeModule do
    @moduledoc """
    About the module
    """
    use AnotherModule
  end

  # preferred
  defmodule SomeModule do
    @moduledoc """
    About the module
    """

    use AnotherModule
  end
  ```

* <a name="heredocs"></a>
  Use heredocs with markdown for documentation.
  <sup>[[link](#heredocs)]</sup>

  ```elixir
  # not preferred
  defmodule SomeModule do
    @moduledoc "About the module"
  end

  defmodule SomeModule do
    @moduledoc """
    About the module

    Examples:
    iex> SomeModule.some_function
    :result
    """
  end

  # preferred
  defmodule SomeModule do
    @moduledoc """
    About the module

    ## Examples

        iex> SomeModule.some_function
        :result
    """
  end
  ```

### Typespecs

Typespecs are notation for declaring types and specifications, for
documentation or for the static analysis tool Dialyzer.

Custom types should be defined at the top of the module with the other
directives (see [Modules](#modules)).

* <a name="typedocs"></a>
  Place `@typedoc` and `@type` definitions together, and separate each
  pair with a blank line.
  <sup>[[link](#typedocs)]</sup>

  ```elixir
  defmodule SomeModule do
    @moduledoc false

    @typedoc "The name"
    @type name :: atom

    @typedoc "The result"
    @type result :: {:ok, term} | {:error, term}

    ...
  end
  ```

* <a name="union-types"></a>
  If a union type is too long to fit on a single line, put each part of the
  type on a separate line, indented one level past the name of the type.
  <sup>[[link](#union-types)]</sup>

  ```elixir
  # not preferred
  @type long_union_type ::
          some_type | another_type | some_other_type | one_more_type | a_final_type

  # preferred
  @type long_union_type ::
          some_type
          | another_type
          | some_other_type
          | one_more_type
          | a_final_type
  ```

* <a name="naming-main-types"></a>
  Name the main type for a module `t`, for example: the type specification for a
  struct.
  <sup>[[link](#naming-main-types)]</sup>

  ```elixir
  defstruct [:name, params: []]

  @type t :: %__MODULE__{
          name: String.t() | nil,
          params: Keyword.t()
        }
  ```

* <a name="spec-spacing"></a>
  Place specifications right before the function definition,
  after the `@doc`,
  without separating them by a blank line.
  <sup>[[link](#spec-spacing)]</sup>

  ```elixir
  @doc """
  Some function description.
  """
  @spec some_function(term) :: result
  def some_function(some_data) do
    {:ok, some_data}
  end
  ```

### Structs

* <a name="nil-struct-field-defaults"></a>
  Use a list of atoms for struct fields that default to `nil`, followed by the
  other keywords.
  <sup>[[link](#nil-struct-field-defaults)]</sup>

  ```elixir
  # not preferred
  defstruct name: nil, params: nil, active: true

  # preferred
  defstruct [:name, :params, active: true]
  ```

* <a name="struct-def-brackets"></a>
  Omit square brackets when the argument of a `defstruct` is a keyword list.
  <sup>[[link](#struct-def-brackets)]</sup>

  ```elixir
  # not preferred
  defstruct [params: [], active: true]

  # preferred
  defstruct params: [], active: true

  # required - brackets are not optional, with at least one atom in the list
  defstruct [:name, params: [], active: true]
  ```

* <a name="multiline-structs"></a>
  If a struct definition spans multiple lines, put each element on its own line,
  keeping the elements aligned.
  <sup>[[link](#multiline-structs)]</sup>

  ```elixir
  defstruct foo: "test",
            bar: true,
            baz: false,
            qux: false,
            quux: 1
  ```

  If a multiline struct requires brackets, format it as a multiline list:

  ```elixir
  defstruct [
    :name,
    params: [],
    active: true
  ]
  ```

### Exceptions

* <a name="exception-names"></a>
  Make exception names end with a trailing `Error`.
  <sup>[[link](#exception-names)]</sup>

  ```elixir
  # not preferred
  defmodule BadHTTPCode do
    defexception [:message]
  end

  defmodule BadHTTPCodeException do
    defexception [:message]
  end

  # preferred
  defmodule BadHTTPCodeError do
    defexception [:message]
  end
  ```

* <a name="lowercase-error-messages"></a>
  Use lowercase error messages when raising exceptions, with no trailing
  punctuation.
  <sup>[[link](#lowercase-error-messages)]</sup>

  ```elixir
  # not preferred
  raise ArgumentError, "This is not valid."

  # preferred
  raise ArgumentError, "this is not valid"
  ```

### Collections

* <a name="keyword-list-syntax"></a>
  Always use the special syntax for keyword lists.
  <sup>[[link](#keyword-list-syntax)]</sup>

  ```elixir
  # not preferred
  some_value = [{:a, "baz"}, {:b, "qux"}]

  # preferred
  some_value = [a: "baz", b: "qux"]
  ```

* <a name="map-key-atom"></a>
  Use the shorthand key-value syntax for maps when all of the keys are atoms.
  <sup>[[link](#map-key-atom)]</sup>

  ```elixir
  # not preferred
  %{:a => 1, :b => 2, :c => 0}

  # preferred
  %{a: 1, b: 2, c: 3}
  ```

* <a name="map-key-arrow"></a>
  Use the verbose key-value syntax for maps if any key is not an atom.
  <sup>[[link](#map-key-arrow)]</sup>

  ```elixir
  # not preferred
  %{"c" => 0, a: 1, b: 2}

  # preferred
  %{:a => 1, :b => 2, "c" => 0}
  ```

### Strings

* <a name="strings-matching-with-concatenator"></a>
  Match strings using the string concatenator rather than binary patterns:
  <sup>[[link](#strings-matching-with-concatenator)]</sup>

  ```elixir
  # not preferred
  <<"my"::utf8, _rest::bytes>> = "my string"

  # preferred
  "my" <> _rest = "my string"
  ```

### Regular Expressions

_No guidelines for regular expressions have been added yet._

### Metaprogramming

* <a name="avoid-metaprogramming"></a>
  Avoid needless metaprogramming.
  <sup>[[link](#avoid-metaprogramming)]</sup>

### Testing

* <a name="testing-assert-order"></a>
  When writing [ExUnit] assertions, put the expression being tested to the left
  of the operator, and the expected result to the right, unless the assertion is
  a pattern match.
  <sup>[[link](#testing-assert-order)]</sup>

  ```elixir
  # preferred
  assert actual_function(1) == true

  # not preferred
  assert true == actual_function(1)

  # required - the assertion is a pattern match
  assert {:ok, expected} = actual_function(3)
  ```

## Resources

### Alternative Style Guides

* [Aleksei Magusev's Elixir Style Guide](https://github.com/lexmag/elixir-style-guide#readme)
  — An opinionated Elixir style guide stemming from the coding style practiced
  in the Elixir core libraries.
  Developed by [Aleksei Magusev](https://github.com/lexmag) and
  [Andrea Leopardi](https://github.com/whatyouhide), members of Elixir core team.
  While the Elixir project doesn't adhere to any specific style guide,
  this is the closest available guide to its conventions.

* [Credo's Elixir Style Guide](https://github.com/rrrene/elixir-style-guide#readme)
  — Style Guide for the Elixir language, implemented by
  [Credo](http://credo-ci.org) static code analysis tool.

### Tools

Refer to [Awesome Elixir][Code Analysis] for libraries and tools that can help
with code analysis and style linting.

## Getting Involved

### Contributing

It's our hope that this will become a central hub for community discussion on
best practices in Elixir.
Feel free to open tickets or send pull requests with improvements.
Thanks in advance for your help!

Check the [contributing guidelines][Contributing] for more information.

### Spread the Word

A community style guide is meaningless without the community's support. Please
tweet, [star][Stargazers], and let any Elixir programmer know
about [this guide][Elixir Style Guide] so they can contribute.

## Copying

### License

![Creative Commons License](http://i.creativecommons.org/l/by/3.0/88x31.png)
This work is licensed under a
[Creative Commons Attribution 3.0 Unported License][License]

### Attribution

The structure of this guide, bits of example code, and many of the initial
points made in this document were borrowed from the [Ruby community style guide].
A lot of things were applicable to Elixir and allowed us to get _some_ document
out quicker to start the conversation.

Here's the [list of people who have kindly contributed][Contributors] to this
project.

<!-- Links -->
[Chinese Simplified]: https://github.com/geekerzp/elixir_style_guide/blob/master/README-zhCN.md
[Chinese Traditional]: https://github.com/elixirtw/elixir_style_guide/blob/master/README_zhTW.md
[Code Analysis]: https://github.com/h4cc/awesome-elixir#code-analysis
[Code Of Conduct]: https://github.com/elixir-lang/elixir/blob/master/CODE_OF_CONDUCT.md
[Code Formatter]: https://hexdocs.pm/elixir/Code.html#format_string!/2
[Conflicting Aliases]: https://elixirforum.com/t/using-aliases-for-fubar-fubar-named-module/1723
[Contributing]: https://github.com/christopheradams/elixir_style_guide/blob/master/CONTRIBUTING.md
[Contributors]: https://github.com/christopheradams/elixir_style_guide/graphs/contributors
[Elixir Style Guide]: https://github.com/christopheradams/elixir_style_guide
[Elixir]: http://elixir-lang.org
[ExDoc]: https://github.com/elixir-lang/ex_doc
[ExUnit]: https://hexdocs.pm/ex_unit/ExUnit.html
[French]: https://github.com/ronanboiteau/elixir_style_guide/blob/master/README_frFR.md
[Guard Expressions]: https://hexdocs.pm/elixir/guards.html#list-of-allowed-expressions
[Hex]: https://hex.pm/packages
[Japanese]: https://github.com/kenichirow/elixir_style_guide/blob/master/README-jaJP.md
[Korean]: https://github.com/marocchino/elixir_style_guide/blob/new-korean/README-koKR.md
[License]: http://creativecommons.org/licenses/by/3.0/deed.en_US
[Mix format]: https://hexdocs.pm/mix/Mix.Tasks.Format.html
[Module Attributes]: http://elixir-lang.org/getting-started/module-attributes.html#as-annotations
[Portuguese]: https://github.com/gusaiani/elixir_style_guide/blob/master/README_ptBR.md
[Ruby community style guide]: https://github.com/bbatsov/ruby-style-guide
[Sentence Spacing]: http://en.wikipedia.org/wiki/Sentence_spacing
[Spanish]: https://github.com/albertoalmagro/elixir_style_guide/blob/spanish/README_esES.md
[Stargazers]: https://github.com/christopheradams/elixir_style_guide/stargazers
