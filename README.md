# The Elixir Style Guide

## Table of Contents

* __[Prelude](#prelude)__
* __[About](#about)__
* __[Formatting](#formatting)__
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
  * [Strings](#strings)
  * [Booleans](#booleans)
  * [Metaprogramming](#metaprogramming)
  * [Testing](#testing)
* __[Resources](#resources)__
  * [Tools](#tools)
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

This is the Avocado style guide for the [Elixir programming language][Elixir].
Please feel free to make pull requests and suggestions.

## Formatting

Elixir v1.6 introduced a [Code Formatter] and [Mix format] task.
The formatter should be preferred for all new projects and source code.

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

* <a name="pipe-operator"></a>
  Use the pipe operator to chain functions together.
  <sup>[[link](#pipe-operator)]</sup>

  ```elixir
  # not preferred
  String.strip(String.downcase(some_string))

  # preferred
  some_string
  |> String.downcase()
  |> String.strip()

  # Multiline pipelines on the right side of a pattern match
  # should be indented on a new line
  sanitized_string =
    some_string
    |> String.downcase()
    |> String.strip()
  ```

  While this is the preferred method, take into account that copy-pasting
  multiline pipelines into IEx might result in a syntax error, as IEx will
  evaluate the first line without realizing that the next line has a pipeline.

* <a name="avoid-single-pipelines"></a>
  Avoid using the pipe operator just once.
  <sup>[[link](#avoid-single-pipelines)]</sup>

  ```elixir
  # not preferred
  some_string
  |> String.downcase()

  # preferred
  String.downcase(some_string)
  ```

* <a name="bare-variables"></a>
  Use _bare_ variables in the first part of a function chain.
  <sup>[[link](#bare-variables)]</sup>

  ```elixir
  # not preferred
  String.strip(some_string)
  |> String.downcase()
  |> String.codepoints()

  # preferred
  some_string
  |> String.strip()
  |> String.downcase()
  |> String.codepoints()

  # not preferred
  keyed_structure[key]
  |> Float.round()
  |> Float.to_string()

  # preferred
  keyed_structure
  |> Access.get(key)
  |> Float.round()
  |> Float.to_string()

  # not preferred
  map.date
  |> Date.add(7)
  |> Date.quarter_of_year()

  # preferred
  map
  |> Map.fetch!(date)
  |> Date.add(7)
  |> Date.quarter_of_year()
  ```

* <a name="parentheses"></a>
  Omit parentheses when a `def` has no arguments.
  <sup>[[link](#parentheses)]</sup>

  ```elixir
  # not preferred
  def some_function() do
    # body omitted
  end

  # preferred
  def some_function do
    # body omitted
  end
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

* <a name="function-calls-and-parentheses"></a>
  Use parentheses in function calls, especially inside a pipeline.
  <sup>[[link](#function-calls-and-parentheses)]</sup>

  ```elixir
  # not preferred
  def my_func do
    # is this a variable or a function call?
    make_ref
  end

  # preferred
  def my_func do
    # this is clearly a function call
    make_ref()
  end

  # not preferred
  2
  |> rem 3
  |> g

  # preferred
  2
  |> rem(3)
  |> g()

  # not preferred
  some_string
  |> String.downcase()
  |> byte_size

  # preferred
  some_string
  |> String.downcase()
  |> byte_size()
  ```

* <a name="keyword-list-syntax"></a>
  Always use the special syntax for keyword lists.
  <sup>[[link](#keyword-list-syntax)]</sup>

  ```elixir
  # not preferred
  some_value = [{:a, "baz"}, {:b, "qux"}]

  # preferred
  some_value = [a: "baz", b: "qux"]
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
  Use `CamelCase` for modules. Treat initialisms like ordinary words.
  <sup>[[link](#camel-case)]</sup>

  ```elixir
  # not preferred
  defmodule Somemodule do
    ...
  end

  defmodule Some_Module do
    ...
  end

  defmodule SomeXML do
    ...
  end

  # preferred
  defmodule SomeModule do
    ...
  end

  defmodule SomeXml do
    ...
  end
  ```

* <a name="predicate-macro-names-with-guards"></a>
  The names of predicate macros (compile-time generated functions that return a
  boolean value) _that can be used within guards_ should be prefixed with `is_`.
  For a list of allowed expressions, see the [Guard][Guard Expressions] docs.
  <sup>[[link](#predicate-macro-names-with-guards)]</sup>

  ```elixir
  defmacro is_cool(var) do
    quote do: unquote(var) == "cool"
  end
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
  Private functions with the same name and arity as public functions should start with `do_`.
  <sup>[[link](#private-functions-with-same-name-as-public)]</sup>

  ```elixir
  def sum(first, second),
    do: do_sum([first, second], 0)

  defp do_sum([], total),
    do: total

  defp do_sum([head | tail], total),
    do: do_sum(tail, head + total)
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

* <a name="compiler-directive-ordering"></a>
  List compiler directives in the following order:
  <sup>[[link](#compiler-directive-ordering)]</sup>

  1. `use`
  2. `alias`
  3. `import`
  4. `require`
  5. `@opaque`
  6. `@type`
  7. `@typep``

  Add a blank line between each grouping, and sort the terms (like module names) alphabetically.
  The `use` macro call comes first since it actually alters the code in your module.
  Note that moduledocs should come directly _after_ `use` calls in your module since these calls override anything preceeding them.

  Here's an overall example of how you should order the directives in your modules:

  ```elixir
    defmodule MyApp.Tardis do
      use GenServer

      @moduledoc """
      A TARDIS data structure and functions.
      """

      alias MyApp.{Companion, Enemy, Planet}
      alias Something, as: S

      import SomethingElse
      import SomethingElseYet

      require Integer

      @opaque t :: %__MODULE__{}

      @type control_room :: binary
      @type chameleon_circuit :: pid

      @typep seq :: pos_integer
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
  Always include a `@moduledoc` attribute directly after the `use` calls in your module.
  If there are no `use` calls, include the `@moduledoc` attribute in the line right after `defmodule`.
  <sup>[[link](#moduledocs)]</sup>

  ```elixir
  # not preferred

  defmodule AnotherModule do
    @moduledoc """
    About the module
    """

    use SomeModule
    ...
  end

  # preferred

  defmodule AThirdModule do
    use SomeModule

    @moduledoc """
    About the module
    """
    ...
  end

  defmodule AFourthModule do
    @moduledoc """
    About the module
    """
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
    require AnotherModule
  end

  # preferred
  defmodule SomeModule do
    @moduledoc """
    About the module
    """

    require AnotherModule
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
  defstruct name: nil, params: []

  @type t :: %__MODULE__{
          name: String.t() | nil,
          params: Keyword.t()
        }
  ```

* <a name="spec-spacing"></a>
  Place specifications right before the function definition,
  without separating them by a blank line.
  <sup>[[link](#spec-spacing)]</sup>

  ```elixir
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

### Booleans

* <a name="boolean-operators"></a>
  Never use `||`, `&&`, or `!` for strictly boolean checks.
  Use these operators only if the primary operand is non-boolean.

  ```elixir
  # not preferred
  is_atom(planet) && name != nil
  is_binary(name) || is_atom(planet)
  !is_map(enemy)

  # preferred
  is_atom(planet) and name != nil
  is_binary(name) or is_atom(planet)
  not is_map(enemy)
  regeneration_count && regeneration_count != 0
  file || "martha_jones.exs"
  !file
  ```

### Metaprogramming

* <a name="avoid-metaprogramming"></a>
  Avoid needless metaprogramming.
  <sup>[[link](#avoid-metaprogramming)]</sup>

### Testing

* <a name="testing-assert-order"></a>
  When writing [ExUnit] assertions, place the expected result to the left of the actual value under test.
  This style of assertion is sometimes referred to as a yoda assertion.
  <sup>[[link](#testing-assert-order)]</sup>

  ```elixir
  # not preferred
  assert actual_function(1) < 1_963
  assert actual_function(2) === "Bad Wolf"
  assert {:ok, expected} = actual_function(3)

  # preferred
  assert 1_963 > actual_function(1)
  assert "Bad Wolf" === actual_function(2)
  assert {:ok, expected} = actual_function(3)
  ```

## Resources

### Tools

Refer to [Awesome Elixir][Code Analysis] for libraries and tools that can help
with code analysis and style linting.

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
[Code Analysis]: https://github.com/h4cc/awesome-elixir#code-analysis
[Code Formatter]: https://hexdocs.pm/elixir/Code.html#format_string!/2
[Conflicting Aliases]: https://elixirforum.com/t/using-aliases-for-fubar-fubar-named-module/1723
[Contributors]: https://github.com/christopheradams/elixir_style_guide/graphs/contributors
[Elixir]: http://elixir-lang.org
[ExDoc]: https://github.com/elixir-lang/ex_doc
[ExUnit]: https://hexdocs.pm/ex_unit/ExUnit.html
[Guard Expressions]: http://elixir-lang.org/getting-started/case-cond-and-if.html#expressions-in-guard-clauses
[Mix format]: https://hexdocs.pm/mix/Mix.Tasks.Format.html
[Module Attributes]: http://elixir-lang.org/getting-started/module-attributes.html#as-annotations
[Ruby community style guide]: https://github.com/bbatsov/ruby-style-guide
[Sentence Spacing]: http://en.wikipedia.org/wiki/Sentence_spacing
