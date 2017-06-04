# [Guía de estilo de Elixir][Elixir Style Guide]

## Tabla de Contenidos

* __[Preludio](#preludio)__
* __[La Guía](#la-guia)__
  * [Disposición del Código Fuente (Layout)](#source-code-layout)
  * [Syntax](#syntax)
  * [Naming](#naming)
  * [Comments](#comments)
    * [Comment Annotations](#comment-annotations)
  * [Modules](#modules)
  * [Documentation](#documentation)
  * [Typespecs](#typespecs)
  * [Structs](#structs)
  * [Exceptions](#exceptions)
  * _Collections_
  * [Strings](#strings)
  * _Regular Expressions_
  * [Metaprogramming](#metaprogramming)
  * [Testing](#testing)
  * [Alternative Style Guides](#alternative-style-guides)
  * [Tools](#tools)
* __[Getting Involved](#getting-involved)__
  * [Contributing](#contributing)
  * [Spread the Word](#spread-the-word)
* __[Copying](#copying)__
  * [License](#license)
  * [Attribution](#attribution)

## Preludio

> Arquitectura líquida. Es como el jazz — improvisáis, trabajáis juntos, tocáis
> los unos con los otros, haces algo, hacen algo.
>
> —Frank Gehry

El estilo importa.
[Elixir] tiene mucho estilo pero como todos los lenguajes puede estropearse.
No estropees el estilo.

## <a name="la-guia">La Guía</a>

Esta es la guía de estilo de la comunidad para
[el lenguaje de programación Elixir][Elixir]. Por favor, se libre de abrir pull requests
y sugerencias, y forma parte de la vibrante comunidad de Elixir.

Si estás buscando otros proyectos en los que contribuir, por favor ve al
[sitio web de Hex package manager][Hex].

### <a name="source-code-layout">Disposición del Código Fuente (Layout)</a>

* <a name="spaces-indentation"></a>
  Usa dos **espacios** por nivel de indentación.
  No utilices tabulaciones.
  <sup>[[enlace](#spaces-indentation)]</sup>

  ```elixir
  # no recomendado - four spaces
  def some_function do
      do_something
  end

  # recomendado
  def some_function do
    do_something
  end
  ```

* <a name="line-endings"></a>
  Usa los finales de línea de Unix (Los usuarios de \*BSD/Solaris/Linux/OSX ya están
  cubiertos por defecto, pero los usuarios de Windows tendrán que prestar especial
  atención).
  <sup>[[enlace](#line-endings)]</sup>

* <a name="autocrlf"></a>
  If you're using Git you might want to add the following configuration
  setting to protect your project from Windows line endings creeping in:
  <sup>[[enlace](#autocrlf)]</sup>

  ```sh
  git config --global core.autocrlf true
  ```

* <a name="spaces"></a>
  Use spaces around operators, after commas, colons and semicolons.
  Do not put spaces around matched pairs like brackets, parentheses, etc.
  Whitespace might be (mostly) irrelevant to the Elixir runtime, but its proper
  use is the key to writing easily readable code.
  <sup>[[enlace](#spaces)]</sup>

  ```elixir
  sum = 1 + 2
  {a, b} = {2, 3}
  [first | rest] = [1, 2, 3]
  Enum.map(["one", <<"two">>, "three"], fn num -> IO.puts num end)
  ```

* <a name="no-spaces"></a>
  Do not use spaces after non-word operators that only take one argument; or
  around the range operator.
  <sup>[[enlace](#no-spaces)]</sup>

  ```elixir
  0 - 1 == -1
  ^pinned = some_func()
  5 in 1..10
  ```

* <a name="def-spacing"></a>
  Use blank lines between `def`s to break up a function into logical
  paragraphs.
  <sup>[[enlace](#def-spacing)]</sup>

  ```elixir
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

* <a name="single-line-defs"></a>
  ...but run single-line `def`s that match for the same function together.
  <sup>[[enlace](#single-line-defs)]</sup>

  ```elixir
  def some_function(nil), do: {:err, "No Value"}
  def some_function([]), do: :ok
  def some_function([first | rest]) do
    some_function(rest)
  end
  ```

* <a name="long-dos"></a>
  If you use the `do:` syntax with functions and the line that makes up the
  function body is long, put the `do:` on a new line indented one level more
  than the previous line.
  <sup>[[enlace](#long-dos)]</sup>

  ```elixir
  def some_function(args),
    do: Enum.map(args, fn(arg) -> arg <> " is on a very long line!" end)
  ```

  When you use the convention above and you have more than one function clause
  using the `do:` syntax, put the `do:` on a new line for each function clause:

  ```elixir
  # no recomendado
  def some_function([]), do: :empty
  def some_function(_),
    do: :very_long_line_here

  # recomendado
  def some_function([]),
    do: :empty
  def some_function(_),
    do: :very_long_line_here
  ```

* <a name="multiple-function-defs"></a>
  If you have more than one multi-line `def`s do not use single-line `def`s.
  <sup>[[enlace](#multiple-function-defs)]</sup>

  ```elixir
  def some_function(nil) do
    {:err, "No Value"}
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
  Use the pipe operator (`|>`) to chain functions together.
  <sup>[[enlace](#pipe-operator)]</sup>

  ```elixir
  # no recomendado
  String.strip(String.downcase(some_string))

  # recomendado
  some_string |> String.downcase |> String.strip

  # Multiline pipelines are not further indented
  some_string
  |> String.downcase
  |> String.strip

  # Multiline pipelines on the right side of a pattern match
  # should be indented on a new line
  sanitized_string =
    some_string
    |> String.downcase
    |> String.strip
  ```

  While this is the preferred method, take into account that copy-pasting
  multiline pipelines into IEx might result in a syntax error, as IEx will
  evaluate the first line without realizing that the next line has a pipeline.

* <a name="avoid-single-pipelines"></a>
  Avoid using the pipe operator just once.
  <sup>[[enlace](#avoid-single-pipelines)]</sup>

  ```elixir
  # no recomendado
  some_string |> String.downcase

  # recomendado
  String.downcase(some_string)
  ```

* <a name="bare-variables"></a>
  Use _bare_ variables in the first part of a function chain.
  <sup>[[enlace](#bare-variables)]</sup>

  ```elixir
  # THE WORST!
  # This actually parses as String.strip("nope" |> String.downcase).
  String.strip "nope" |> String.downcase

  # no recomendado
  String.strip(some_string) |> String.downcase |> String.codepoints

  # recomendado
  some_string |> String.strip |> String.downcase |> String.codepoints
  ```

* <a name="multiline-list-assign"></a>
  When assigning a list that spans multiple lines, start the list on a newline,
  and indent the elements to keep them aligned.
  <sup>[[enlace](#multiline-list-assign)]</sup>

  ```elixir
  # no recomendado - no indentation
  list = [:first_item, :second_item, :next_item,
  :last_item]

  # better, but not preferred - with indentation
  list = [:first_item, :second_item, :next_item,
          :last_item]

  # recomendado - list starts on its own line
  # good for shorter, more compact lists
  list =
    [:first_item, :second_item, :next_item,
     :last_item]

  # also preferred - when each element is on its own line
  # good for long lists, lists with long elements, or lists with comments
  list = [
    :first_item,
    :second_item,
    :next_item,
    # comment
    :many_items,
    :last_item
  ]
  ```

* <a name="trailing-whitespace"></a>
  Avoid trailing whitespace.
  <sup>[[enlace](#trailing-whitespace)]</sup>

* <a name="newline-eof"></a>
  End each file with a newline.
  <sup>[[enlace](#newline-eof)]</sup>

### Syntax

* <a name="parentheses"></a>
  Use parentheses when a `def` has arguments, and omit them when it doesn't.
  <sup>[[enlace](#parentheses)]</sup>

  ```elixir
  # no recomendado
  def some_function arg1, arg2 do
    # body omitted
  end

  def some_function() do
    # body omitted
  end

  # recomendado
  def some_function(arg1, arg2) do
    # body omitted
  end

  def some_function do
    # body omitted
  end
  ```

* <a name="add-blank-line-after-multiline-assignment"></a>
  Add a blank line after a multiline assignment as a
  visual cue that the assignment is 'over'.
  <sup>[[enlace](#add-blank-line-after-multiline-assignment)]</sup>

  ```elixir
  # no recomendado
  some_string =
    "Hello"
    |> String.downcase
    |> String.strip
  another_string <> some_string

  # recomendado
  some_string =
    "Hello"
    |> String.downcase
    |> String.strip

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
  something |> String.downcase

  # recomendado
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end

  something |> String.downcase
  ```

* <a name="do-with-multi-line-if-unless"></a>
  Never use `do:` for multi-line `if/unless`.
  <sup>[[enlace](#do-with-multi-line-if-unless)]</sup>

  ```elixir
  # no recomendado
  if some_condition, do:
    # a line of code
    # another line of code
    # note no end in this block

  # recomendado
  if some_condition do
    # some
    # lines
    # of code
  end
  ```

* <a name="do-with-single-line-if-unless"></a>
  Use `do:` for single line `if/unless` statements.
  <sup>[[enlace](#do-with-single-line-if-unless)]</sup>

  ```elixir
  # recomendado
  if some_condition, do: # some_stuff
  ```

* <a name="unless-with-else"></a>
  Never use `unless` with `else`.
  Rewrite these with the positive case first.
  <sup>[[enlace](#unless-with-else)]</sup>

  ```elixir
  # no recomendado
  unless success? do
    IO.puts 'failure'
  else
    IO.puts 'success'
  end

  # recomendado
  if success? do
    IO.puts 'success'
  else
    IO.puts 'failure'
  end
  ```

* <a name="true-as-last-condition"></a>
  Use `true` as the last condition of the `cond` special form when you need a
  clause that always matches.
  <sup>[[enlace](#true-as-last-condition)]</sup>

  ```elixir
  # no recomendado
  cond do
    1 + 2 == 5 ->
      "Nope"
    1 + 3 == 5 ->
      "Uh, uh"
    :else ->
      "OK"
  end

  # recomendado
  cond do
    1 + 2 == 5 ->
      "Nope"
    1 + 3 == 5 ->
      "Uh, uh"
    true ->
      "OK"
  end
  ```

* <a name="function-names-with-parentheses"></a>
  Never put a space between a function name and the opening parenthesis.
  <sup>[[enlace](#function-names-with-parentheses)]</sup>

  ```elixir
  # no recomendado
  f (3 + 2) + 1

  # recomendado
  f(3 + 2) + 1
  ```

* <a name="function-calls-and-parentheses"></a>
  Use parentheses in function calls, especially inside a pipeline.
  <sup>[[enlace](#function-calls-and-parentheses)]</sup>

  ```elixir
  # no recomendado
  f 3

  # recomendado
  f(3)

  # no recomendado and parses as rem(2, (3 |> g)), which is not what you want.
  2 |> rem 3 |> g

  # recomendado
  2 |> rem(3) |> g
  ```

* <a name="macro-calls-and-parentheses"></a>
  Omit parentheses in macro calls when a do block is passed.
  <sup>[[enlace](#macro-calls-and-parentheses)]</sup>

  ```elixir
  # no recomendado
  quote(do
    foo
  end)

  # recomendado
  quote do
    foo
  end
  ```

* <a name="parentheses-and-function-expressions"></a>
  Optionally omit parentheses in function calls (outside a pipeline) when the
  last argument is a function expression.
  <sup>[[enlace](#parentheses-and-function-expressions)]</sup>

  ```elixir
  # recomendado
  Enum.reduce(1..10, 0, fn x, acc ->
    x + acc
  end)

  # also preferred
  Enum.reduce 1..10, 0, fn x, acc ->
    x + acc
  end
  ```

* <a name="parentheses-and-functions-with-zero-arity"></a>
  Use parentheses for calls to functions with zero arity, so they can be
  distinguished from variables.
  Starting in Elixir 1.4, the compiler will warn you about
  locations where this ambiguity exists.
  <sup>[[enlace](#parentheses-and-functions-with-zero-arity)]</sup>

  ```elixir
  defp do_stuff, do: ...

  # no recomendado
  def my_func do
    do_stuff # is this a variable or a function call?
  end

  # recomendado
  def my_func do
    do_stuff() # this is clearly a function call
  end
  ```

* <a name="keyword-list-syntax"></a>
  Always use the special syntax for keyword lists.
  <sup>[[enlace](#keyword-list-syntax)]</sup>

  ```elixir
  # no recomendado
  some_value = [{:a, "baz"}, {:b, "qux"}]

  # recomendado
  some_value = [a: "baz", b: "qux"]
  ```

* <a name="keyword-list-brackets"></a>
  Omit square brackets from keyword lists whenever they are optional.
  <sup>[[enlace](#keyword-list-brackets)]</sup>

  ```elixir
  # no recomendado
  some_function(foo, bar, [a: "baz", b: "qux"])

  # recomendado
  some_function(foo, bar, a: "baz", b: "qux")
  ```

* <a name="with-clauses"></a>
  Indent and align successive `with` clauses.
  Put the `do:` argument on a new line, indented normally.
  <sup>[[enlace](#with-clauses)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, bar} <- fetch(opts, :bar),
    do: {:ok, foo, bar}
  ```

* <a name="with-else"></a>
  If the `with` expression has a `do` block with more than one line, or has an
  `else` option, use multiline syntax.
  <sup>[[enlace](#with-else)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, bar} <- fetch(opts, :bar) do
    {:ok, foo, bar}
  else
    :error ->
      {:error, :bad_arg}
  end
  ```

### Naming

* <a name="snake-case"></a>
  Use `snake_case` for atoms, functions and variables.
  <sup>[[enlace](#snake-case)]</sup>

  ```elixir
  # no recomendado
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

  # recomendado
  :some_atom

  some_var = 5

  def some_function do
    ...
  end
  ```

* <a name="camel-case"></a>
  Use `CamelCase` for modules (keep acronyms like HTTP, RFC, XML uppercase).
  <sup>[[enlace](#camel-case)]</sup>

  ```elixir
  # no recomendado
  defmodule Somemodule do
    ...
  end

  defmodule Some_Module do
    ...
  end

  defmodule SomeXml do
    ...
  end

  # recomendado
  defmodule SomeModule do
    ...
  end

  defmodule SomeXML do
    ...
  end
  ```

* <a name="predicate-macro-names-with-guards"></a>
  The names of predicate macros (compile-time generated functions that return a
  boolean value) _that can be used within guards_ should be prefixed with `is_`.
  For a list of allowed expressions, see the [Guard][Guard Expressions] docs.
  <sup>[[enlace](#predicate-macro-names-with-guards)]</sup>

  ```elixir
  defmacro is_cool(var) do
    quote do: unquote(var) == "cool"
  end
  ```

* <a name="predicate-macro-names-no-guards"></a>
  The names of predicate functions _that cannot be used within guards_ should
  have a trailing question mark (`?`) rather than the `is_` (or similar) prefix.
  <sup>[[enlace](#predicate-macro-names-no-guards)]</sup>

  ```elixir
  def cool?(var) do
    # Complex check if var is cool not possible in a pure function.
  end
  ```

* <a name="private-functions-with-same-name-as-public"></a>
  Private functions with the same name as public functions should start with
  `do_`.
  <sup>[[enlace](#private-functions-with-same-name-as-public)]</sup>

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
  <sup>[[enlace](#expressive-code)]</sup>

* <a name="comment-leading-spaces"></a>
  Use one space between the leading `#` character of the comment and the text of
  the comment.
  <sup>[[enlace](#comment-leading-spaces)]</sup>

  ```elixir
  String.first(some_string) #not preferred
  String.first(some_string) # recomendado
  ```

* <a name="comment-grammar"></a>
  Comments longer than a word are capitalized, and sentences use punctuation.
  Use [one space][Sentence Spacing] after periods.
  <sup>[[enlace](#comment-grammar)]</sup>

  ```elixir
  # no recomendado
  # these lowercase comments are missing punctuation

  # recomendado
  # Capitalization example
  # Use punctuation for complete sentences.
  ```

#### Comment Annotations

* <a name="annotations"></a>
  Annotations should usually be written on the line immediately above the
  relevant code.
  <sup>[[enlace](#annotations)]</sup>

* <a name="annotation-keyword"></a>
  The annotation keyword is uppercase, and is followed by a colon and a space,
  then a note describing the problem.
  <sup>[[enlace](#annotation-keyword)]</sup>

  ```elixir
  # TODO: Deprecate in v1.5.
  def some_function(arg), do: {:ok, arg}
  ```

* <a name="exceptions-to-annotations"></a>
  In cases where the problem is so obvious that any documentation would be
  redundant, annotations may be left at the end of the offending line with no
  note.
  This usage should be the exception and not the rule.
  <sup>[[enlace](#exceptions-to-annotations)]</sup>

  ```elixir
  start_task()
  Process.sleep(5000) # FIXME
  ```

* <a name="todo-notes"></a>
  Use `TODO` to note missing features or functionality that should be added at a
  later date.
  <sup>[[enlace](#todo-notes)]</sup>

* <a name="fixme-notes"></a>
  Use `FIXME` to note broken code that needs to be fixed.
  <sup>[[enlace](#fixme-notes)]</sup>

* <a name="optimize-notes"></a>
  Use `OPTIMIZE` to note slow or inefficient code that may cause performance
  problems.
  <sup>[[enlace](#optimize-notes)]</sup>

* <a name="hack-notes"></a>
  Use `HACK` to note code smells where questionable coding practices were used
  and should be refactored away.
  <sup>[[enlace](#hack-notes)]</sup>

* <a name="review-notes"></a>
  Use `REVIEW` to note anything that should be looked at to confirm it is
  working as intended.
  For example: `REVIEW: Are we sure this is how the client does X currently?`
  <sup>[[enlace](#review-notes)]</sup>

* <a name="custom-keywords"></a>
  Use other custom annotation keywords if it feels appropriate, but be sure to
  document them in your project's `README` or similar.
  <sup>[[enlace](#custom-keywords)]</sup>

### Modules

* <a name="one-module-per-file"></a>
  Use one module per file unless the module is only used internally by another
  module (such as a test).
  <sup>[[enlace](#one-module-per-file)]</sup>

* <a name="underscored-filenames"></a>
  Use `snake_case` file names for `CamelCase` module names.
  <sup>[[enlace](#underscored-filenames)]</sup>

  ```elixir
  # file is called some_module.ex

  defmodule SomeModule do
  end
  ```

* <a name="module-name-nesting"></a>
  Represent each level of nesting within a module name as a directory.
  <sup>[[enlace](#module-name-nesting)]</sup>

  ```elixir
  # file is called parser/core/xml_parser.ex

  defmodule Parser.Core.XMLParser do
  end
  ```

* <a name="defmodule-spacing"></a>
  Don't put a blank line after `defmodule`.
  <sup>[[enlace](#defmodule-spacing)]</sup>

* <a name="module-block-spacing"></a>
  Put a blank line after module-level code blocks.
  <sup>[[enlace](#module-block-spacing)]</sup>

* <a name="module-attribute-ordering"></a>
  List module attributes and directives in the following order:
  <sup>[[enlace](#module-attribute-ordering)]</sup>

  1. `@moduledoc`
  1. `@behaviour`
  1. `use`
  1. `import`
  1. `alias`
  1. `require`
  1. `defstruct`
  1. `@type`
  1. `@module_attribute`
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

    defstruct name: nil, params: []

    @type params :: [{binary, binary}]

    @module_attribute :foo
    @other_attribute 100

    @callback some_function(term) :: :ok | {:error, term}

    @macrocallback macro_name(term) :: Macro.t

    @optional_callbacks macro_name: 1

    ...
  end
  ```

* <a name="module-pseudo-variable"></a>
  Use the `__MODULE__` pseudo variable when a module refers to itself. This
  avoids having to update any self-references when the module name changes.
  <sup>[[enlace](#module-pseudo-variable)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    defstruct [:name]

    def name(%__MODULE__{name: name}), do: name
  end
  ```

* <a name="alias-self-referencing-modules"></a>
  If you want a prettier name for a module self-reference, set up an alias.
  <sup>[[enlace](#alias-self-referencing-modules)]</sup>

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
  <sup>[[enlace](#repetitive-module-names)]</sup>

  ```elixir
  # no recomendado
  defmodule Todo.Todo do
    ...
  end

  # recomendado
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
  <sup>[[enlace](#moduledocs)]</sup>

  ```elixir
  # no recomendado

  defmodule SomeModule do

    @moduledoc """
    About the module
    """
    ...
  end

  defmodule AnotherModule do
    use SomeModule
    @moduledoc """
    About the module
    """
    ...
  end

  # recomendado

  defmodule SomeModule do
    @moduledoc """
    About the module
    """
    ...
  end
  ```

* <a name="moduledoc-false"></a>
  Use `@moduledoc false` if you do not intend on documenting the module.
  <sup>[[enlace](#moduledoc-false)]</sup>

  ```elixir
  defmodule SomeModule do
    @moduledoc false
    ...
  end
  ```

* <a name="moduledoc-spacing"></a>
  Separate code after the `@moduledoc` with a blank line.
  <sup>[[enlace](#moduledoc-spacing)]</sup>

  ```elixir
  # no recomendado

  defmodule SomeModule do
    @moduledoc """
    About the module
    """
    use AnotherModule
  end

  # recomendado
  defmodule SomeModule do
    @moduledoc """
    About the module
    """

    use AnotherModule
  end
  ```

* <a name="heredocs"></a>
  Use heredocs with markdown for documentation.
  <sup>[[enlace](#heredocs)]</sup>

  ```elixir
  # no recomendado

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

  # recomendado
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
  <sup>[[enlace](#typedocs)]</sup>

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
  If a union type is too long to fit on a single line, add a newline
  and indent with spaces to keep the types aligned.
  <sup>[[enlace](#union-types)]</sup>

  ```elixir
  # no recomendado - no indentation
  @type long_union_type :: some_type | another_type | some_other_type |
  a_final_type

  # recomendado
  @type long_union_type :: some_type | another_type | some_other_type |
                           a_final_type

  # also preferred - one type per line
  @type long_union_type :: some_type |
                           another_type |
                           some_other_type |
                           a_final_type
  ```

* <a name="naming-main-types"></a>
  Name the main type for a module `t`, for example: the type specification for a
  struct.
  <sup>[[enlace](#naming-main-types)]</sup>

  ```elixir
  defstruct name: nil, params: []

  @type t :: %__MODULE__{
    name: String.t | nil,
    params: Keyword.t
  }
  ```

* <a name="spec-spacing"></a>
  Place specifications right before the function definition,
  without separating them by a blank line.
  <sup>[[enlace](#spec-spacing)]</sup>

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
  <sup>[[enlace](#nil-struct-field-defaults)]</sup>

  ```elixir
  # no recomendado
  defstruct name: nil, params: nil, active: true

  # recomendado
  defstruct [:name, :params, active: true]
  ```

* <a name="struct-def-brackets"></a>
  Omit square brackets when the argument of a `defstruct` is a keyword list.
  <sup>[[enlace](#struct-def-brackets)]</sup>

  ```elixir
  # no recomendado
  defstruct [params: [], active: true]

  # recomendado
  defstruct params: [], active: true

  # required - brackets are not optional, with at least one atom in the list
  defstruct [:name, params: [], active: true]
  ```

* <a name="additional-struct-def-lines"></a>
  Indent additional lines of the struct definition, keeping the first keys
  aligned.
  <sup>[[enlace](#additional-struct-def-lines)]</sup>

  ```elixir
  defstruct foo: "test", bar: true, baz: false,
            qux: false, quux: 1
  ```

### Exceptions

* <a name="exception-names"></a>
  Make exception names end with a trailing `Error`.
  <sup>[[enlace](#exception-names)]</sup>

  ```elixir
  # no recomendado
  defmodule BadHTTPCode do
    defexception [:message]
  end

  defmodule BadHTTPCodeException do
    defexception [:message]
  end

  # recomendado
  defmodule BadHTTPCodeError do
    defexception [:message]
  end
  ```

* <a name="lowercase-error-messages"></a>
  Use lowercase error messages when raising exceptions, with no trailing
  punctuation.
  <sup>[[enlace](#lowercase-error-messages)]</sup>

  ```elixir
  # no recomendado
  raise ArgumentError, "This is not valid."

  # recomendado
  raise ArgumentError, "this is not valid"
  ```

### Collections

_No guidelines for collections have been added yet._

### Strings

* <a name="strings-matching-with-concatenator"></a>
  Match strings using the string concatenator rather than binary patterns:
  <sup>[[enlace](#strings-matching-with-concatenator)]</sup>

  ```elixir
  # no recomendado
  <<"my"::utf8, _rest>> = "my string"

  # recomendado
  "my" <> _rest = "my string"
  ```

### Regular Expressions

_No guidelines for regular expressions have been added yet._

### Metaprogramming

* <a name="avoid-metaprogramming"></a>
  Avoid needless metaprogramming.
  <sup>[[enlace](#avoid-metaprogramming)]</sup>

### Testing

* <a name="testing-assert-order"></a>
  When writing [ExUnit] assertions, be consistent with the order of the expected
  and actual values under testing.
  Prefer placing the expected result on the right, unless the assertion is a
  pattern match.
  <sup>[[Enlace](#testing-assert-order)]</sup>

  ```elixir
  # recomendado - expected result on the right
  assert actual_function(1) == true
  assert actual_function(2) == false

  # no recomendado - inconsistent order
  assert actual_function(1) == true
  assert false == actual_function(2)

  # required - the assertion is a pattern match
  assert {:ok, expected} = actual_function(3)
  ```

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

Check the [contributing guidelines][Contributing]
and [code of conduct][Code Of Conduct] for more information.

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

Aquí está la [lista de gente que ha contribuido amablemente][Contributors] a este
proyecto.

<!-- Enlaces -->
[Chinese Traditional]: https://github.com/elixirtw/elixir_style_guide/blob/master/README_zhTW.md
[Code Analysis]: https://github.com/h4cc/awesome-elixir#code-analysis
[Code Of Conduct]: https://github.com/christopheradams/elixir_style_guide/blob/master/CODE_OF_CONDUCT.md
[Conflicting Aliases]: https://elixirforum.com/t/using-aliases-for-fubar-fubar-named-module/1723
[Contributing]: https://github.com/elixir-lang/elixir/blob/master/CODE_OF_CONDUCT.md
[Contributors]: https://github.com/christopheradams/elixir_style_guide/graphs/contributors
[Elixir Style Guide]: https://github.com/christopheradams/elixir_style_guide
[Elixir]: http://elixir-lang.org
[ExDoc]: https://github.com/elixir-lang/ex_doc
[ExUnit]: https://hexdocs.pm/ex_unit/ExUnit.html
[Guard Expressions]: http://elixir-lang.org/getting-started/case-cond-and-if.html#expressions-in-guard-clauses
[Hex]: https://hex.pm/packages
[Japanese]: https://github.com/kenichirow/elixir_style_guide/blob/master/README-jaJP.md
[Korean]: https://github.com/marocchino/elixir_style_guide/blob/new-korean/README-koKR.md
[License]: http://creativecommons.org/licenses/by/3.0/deed.en_US
[Module Attributes]: http://elixir-lang.org/getting-started/module-attributes.html#as-annotations
[Ruby community style guide]: https://github.com/bbatsov/ruby-style-guide
[Sentence Spacing]: http://en.wikipedia.org/wiki/Sentence_spacing
[Stargazers]: https://github.com/christopheradams/elixir_style_guide/stargazers

