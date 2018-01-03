# [Elixir 风格指南][Elixir Style Guide]

## 目录

* __[序幕](#prelude)__
* __[风格指南](#the-guide)__
  * [组织](#source-code-layout)
  * [语法](#syntax)
  * [命名](#naming)
  * [注释](#comments)
    * [注解](#comment-annotations)
  * [模块](#modules)
  * [文档](#documentation)
  * [类型声明](#typespecs)
  * [结构](#structs)
  * [异常](#exceptions)
  * 集合
  * [字符串](#strings)
  * 正则表达式
  * [元编程](#metaprogramming)
  * [测试](#testing)
  * [更多风格指南](#alternative-style-guides)
  * [工具](#tools)
* __[参与文档](#getting-involved)__
  * [贡献](#contributing)
  * [口耳相传](#spread-the-word)
* __[授权](#copying)__
  * [协议](#license)
  * [归属](#attribution)

## 序幕

> 液体架构。像爵士乐一样 - 你们一起即兴演奏，互相回应着对方，你们在创作着音乐，他们在创作着音乐。
>
> —Frank Gehry

风格很重要。
[Elixir] 有着大量的风格指南，但是像其他语言一样，这些指南都有可能被扼杀。
请不要扼杀这份指南。

## 指南

这是一份社群维护的 [Elixir 编程语言][Elixir] 风格指南。

欢迎提交 pull requests 和建议来完善这份指南，成为 Elixir 富有活力的社区的一员。

你可以在 [Hex 官网][Hex] 寻找其他的项目来贡献代码。

### 代码排版

* <a name="spaces-indentation"></a>
  使用两个 **空格** 进行缩进，不要使用 Hard Tab。
  <sup>[[link](#spaces-indentation)]</sup>

  ```elixir
  # 不好 - 四个空格
  def some_function do
      do_something
  end

  # 好
  def some_function do
    do_something
  end
  ```

* <a name="line-endings"></a>
  使用 Unix 风格换行符 (包括 \*BSD/Solaris/Linux/OSX 的用户, Windows 用户要特别小心)。
  <sup>[[link](#line-endings)]</sup>

* <a name="autocrlf"></a>
  如果你使用 Git，可以使用下面的配置来避免 Windows 风格换行符：
  <sup>[[link](#autocrlf)]</sup>

  ```sh
  git config --global core.autocrlf true
  ```

* <a name="spaces"></a>
  在运算符的两侧添加空格，在逗号`,`，冒号`:`，分号`;`，之后添加空格。
  不要在配对的括号两侧添加空格，例如，小括号`()`，大括号`{}`，等等。
  空格一般来说对 (大部分) Elixir 编译器是无关紧要的，但是恰当的使用空格是写出可读性高的代码的关键。
  <sup>[[link](#spaces)]</sup>

  ```elixir
  sum = 1 + 2
  {a, b} = {2, 3}
  [first | rest] = [1, 2, 3]
  Enum.map(["one", <<"two">>, "three"], fn num -> IO.puts num end)
  ```

* <a name="no-spaces"></a>
  在仅有一个参数的运算符之后，或者是范围运算符前后，不要添加空格。
  <sup>[[link](#no-spaces)]</sup>

  ```elixir
  0 - 1 == -1
  ^pinned = some_func()
  5 in 1..10
  ```

* <a name="def-spacing"></a>
  在 `def` 直接使用空行，并且把函数分成合乎逻辑的段落。
  <sup>[[link](#def-spacing)]</sup>

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
  ...但是具有相同函数名的单行 `def` 写在一起。
  <sup>[[link](#single-line-defs)]</sup>

  ```elixir
  def some_function(nil), do: {:err, "No Value"}
  def some_function([]), do: :ok
  def some_function([first | rest]) do
    some_function(rest)
  end
  ```

* <a name="long-dos"></a>
  当你使用 `do:` 的语法声明函数时，如果函数体太长，将 `do:` 放在新的一行，并且进行缩进。
  <sup>[[link](#long-dos)]</sup>

  ```elixir
  def some_function(args),
    do: Enum.map(args, fn(arg) -> arg <> " is on a very long line!" end)
  ```

  当你使用了上面的风格，并且同时 `do:` 声明多个函数子句时，请把所有的 `do:` 函数子句主体放在

  ```elixir
  # 不好
  def some_function([]), do: :empty
  def some_function(_),
    do: :very_long_line_here

  # 好
  def some_function([]),
    do: :empty
  def some_function(_),
    do: :very_long_line_here
  ```

* <a name="multiple-function-defs"></a>
  如果你使用了多行的 `def`，请不要再使用单行的 `def`。
  <sup>[[link](#multiple-function-defs)]</sup>

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

* <a name="parentheses-pipe-operator"></a>
  使用管道运算符 (`|>`) 时，函数添加括号。
  <sup>[[link](#parentheses-pipe-operator)]</sup>

  ```elixir
  # 不好
  some_string |> String.downcase |> String.strip

  # 好
  some_string |> String.downcase() |> String.strip()
  ```

* <a name="pipe-operator"></a>
  使用管道运算符链接多个函数。
  <sup>[[link](#pipe-operator)]</sup>

  ```elixir
  # 不好
  String.strip(String.downcase(some_string))

  # 好
  some_string |> String.downcase() |> String.strip()

  # 多行管道不需要缩进
  some_string
  |> String.downcase()
  |> String.strip()

  # 多行管道在模式匹配的右侧要在下一行缩进
  sanitized_string =
    some_string
    |> String.downcase()
    |> String.strip()
  ```

  虽然这是推荐的写法，务必记得在 IEx 中直接粘贴多行管道时，可能会引起错误。这是由于 IEx 会
  直接解释第一行，而不会意识到下一行管道的存在。

* <a name="avoid-single-pipelines"></a>
  避免只使用一次的管道。
  <sup>[[link](#avoid-single-pipelines)]</sup>

  ```elixir
  # 不好
  some_string |> String.downcase()

  # 好
  String.downcase(some_string)
  ```

* <a name="bare-variables"></a>

  把纯变量放在函数调用链的开头。

  <sup>[[link](#bare-variables)]</sup>

  ```elixir
  # 非常不好!
  # 这会被编译为 String.strip("nope" |> String.downcase()).
  String.strip "nope" |> String.downcase()

  # 不好
  String.strip(some_string) |> String.downcase() |> String.codepoints()

  # 好
  some_string |> String.strip() |> String.downcase() |> String.codepoints()
  ```

* <a name="multiline-list-assign"></a>

  多行列表进行赋值时，另起一行，并且列表的元素要进行对齐。

  <sup>[[link](#multiline-list-assign)]</sup>

  ```elixir
  # 不好 - 没有缩进
  list = [:first_item, :second_item, :next_item,
  :last_item]

  # 好一点 - 进行缩进
  list = [:first_item, :second_item, :next_item,
          :last_item]

  # 好 - 列表另起一行
  # 适合更短，更紧凑的列表
  list =
    [:first_item, :second_item, :next_item,
     :last_item]

  # 同样很好 - 列表的每个元素另起一行
  # 适合长列表，长元素列表，或者有注释的列表
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
  避免行尾的空白 (trailing whitespace)。
  <sup>[[link](#trailing-whitespace)]</sup>

* <a name="newline-eof"></a>

  用新的一行来结束源文件。

  <sup>[[link](#newline-eof)]</sup>

### 语法

* <a name="parentheses"></a>

  有参函数使用括号，否则省略括号。

  <sup>[[link](#parentheses)]</sup>

  ```elixir
  # 不好
  def some_function arg1, arg2 do
    # body omitted
  end

  def some_function() do
    # body omitted
  end

  # 好
  def some_function(arg1, arg2) do
    # body omitted
  end

  def some_function do
    # body omitted
  end
  ```

* <a name="add-blank-line-after-multiline-assignment"></a>

  多行赋值后添加空行，表示赋值结束。

  <sup>[[link](#add-blank-line-after-multiline-assignment)]</sup>

  ```elixir
  # 不好
  some_string =
    "Hello"
    |> String.downcase()
    |> String.strip()
  another_string <> some_string

  # 好
  some_string =
    "Hello"
    |> String.downcase()
    |> String.strip()

  another_string <> some_string
  ```

  ```elixir
  # 不好
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end
  String.downcase(something)

  # 好
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end

  String.downcase(something)
  ```

* <a name="do-with-multi-line-if-unless"></a>

  多行 `if/unless` 时，避免使用 `do:`。

  <sup>[[link](#do-with-multi-line-if-unless)]</sup>

  ```elixir
  # 不好
  if some_condition, do:
    # a line of code
    # another line of code
    # note no end in this block

  # 好
  if some_condition do
    # some
    # lines
    # of code
  end
  ```

* <a name="do-with-single-line-if-unless"></a>

  单行 `if/unless` 时使用 `do:`。

  <sup>[[link](#do-with-single-line-if-unless)]</sup>

  ```elixir
  # 好
  if some_condition, do: # some_stuff
  ```

* <a name="unless-with-else"></a>

  避免使用 `unless` 搭配 `else`，将它们改写为肯定条件。

  <sup>[[link](#unless-with-else)]</sup>

  ```elixir
  # 不好
  unless success? do
    IO.puts 'failure'
  else
    IO.puts 'success'
  end

  # 好
  if success? do
    IO.puts 'success'
  else
    IO.puts 'failure'
  end
  ```

* <a name="true-as-last-condition"></a>

  `cond` 的最后一个条件一定是 `true` 。

  <sup>[[link](#true-as-last-condition)]</sup>

  ```elixir
  # 不好
  cond do
    1 + 2 == 5 ->
      "Nope"
    1 + 3 == 5 ->
      "Uh, uh"
    :else ->
      "OK"
  end

  # 好
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

  不要在函数名和左括号之间添加空格。

  <sup>[[link](#function-names-with-parentheses)]</sup>

  ```elixir
  # 不好
  f (3 + 2) + 1

  # 好
  f(3 + 2) + 1
  ```

* <a name="function-calls-and-parentheses"></a>

  函数调用时使用括号，特别在使用管道时。

  <sup>[[link](#function-calls-and-parentheses)]</sup>

  ```elixir
  # 不好
  f 3

  # 好
  f(3)

  # 不好
  2 |> rem 3 |> g

  # 好
  2 |> rem(3) |> g
  ```

* <a name="macro-calls-and-parentheses"></a>

  当使用 `do` 块调用宏时，省略括号。

  <sup>[[link](#macro-calls-and-parentheses)]</sup>

  ```elixir
  # 不好
  quote(do
    foo
  end)

  # 好
  quote do
    foo
  end
  ```

* <a name="parentheses-and-function-expressions"></a>

  当函数调用在管道之外，并且最后一个参数是函数表达式时，可以选择性的省略括号。

  <sup>[[link](#parentheses-and-function-expressions)]</sup>

  ```elixir
  # 好
  Enum.reduce(1..10, 0, fn x, acc ->
    x + acc
  end)

  # 同样好
  Enum.reduce 1..10, 0, fn x, acc ->
    x + acc
  end
  ```

* <a name="parentheses-and-functions-with-zero-arity"></a>

  无参函数调用时添加括号，以便和变量进行区分。

  从 Elixir 1.4 开始，编译器会在有歧义的地方发出警告。

  <sup>[[link](#parentheses-and-functions-with-zero-arity)]</sup>

  ```elixir
  defp do_stuff, do: ...

  # 不好
  def my_func do
    do_stuff # 这是变量还是函数调用?
  end

  # 好用
  def my_func do
    do_stuff() # 这是一个明确的函数调用
  end
  ```

* <a name="keyword-list-syntax"></a>

  关键字列表总是使用特殊语法。

  <sup>[[link](#keyword-list-syntax)]</sup>

  ```elixir
  # 不好
  some_value = [{:a, "baz"}, {:b, "qux"}]

  # 好
  some_value = [a: "baz", b: "qux"]
  ```

* <a name="keyword-list-brackets"></a>

  当关键字列表的括号可选时则省略。

  <sup>[[link](#keyword-list-brackets)]</sup>

  ```elixir
  # 不好
  some_function(foo, bar, [a: "baz", b: "qux"])

  # 好
  some_function(foo, bar, a: "baz", b: "qux")
  ```

* <a name="with-clauses"></a>

  缩排 `with` 的多个条件，`do` 的参数在新的一行正常缩进。

  <sup>[[link](#with-clauses)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, bar} <- fetch(opts, :bar),
    do: {:ok, foo, bar}
  ```

* <a name="with-else"></a>

  如果 `with` 表达式 `do` 块超过了一行，或者使用了 `else`，请使用多行语法。

  <sup>[[link](#with-else)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, bar} <- fetch(opts, :bar) do
    {:ok, foo, bar}
  else
    :error ->
      {:error, :bad_arg}
  end
  ```

### 命名

* <a name="snake-case"></a>

  符号，方法，变量，使用蛇底式 (`snake_case`)。

  <sup>[[link](#snake-case)]</sup>

  ```elixir
  # 不好
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

  # 好
  :some_atom

  some_var = 5

  def some_function do
    ...
  end
  ```

* <a name="camel-case"></a>

  模块名使用驼峰式 (`CamelCase`) (保留像是 HTTP, RFC, XML 这种缩写为大写形式)。

  <sup>[[link](#camel-case)]</sup>

  ```elixir
  # 不好
  defmodule Somemodule do
    ...
  end

  defmodule Some_Module do
    ...
  end

  defmodule SomeXml do
    ...
  end

  # 好
  defmodule SomeModule do
    ...
  end

  defmodule SomeXML do
    ...
  end
  ```

* <a name="predicate-macro-names-with-guards"></a>

  可以在 `guard clause` 中使用的谓词宏 (编译期生成返回布尔值的函数)，命名应该使用 `is_` 前缀。

  允许的表达式列表，请参考 [Guard][Guard Expressions] 文档。

  <sup>[[link](#predicate-macro-names-with-guards)]</sup>

  ```elixir
  defmacro is_cool(var) do
    quote do: unquote(var) == "cool"
  end
  ```

* <a name="predicate-macro-names-no-guards"></a>

  谓词函数，无法在 `guard clause` 中使用，命名时应该以 `?` 结尾，而不是 `is_` 作为前缀。

  <sup>[[link](#predicate-macro-names-no-guards)]</sup>

  ```elixir
  def cool?(var) do
    # Complex check if var is cool not possible in a pure function.
  end
  ```

* <a name="private-functions-with-same-name-as-public"></a>

  当私有函数和公共函数具有相同的名称时，使用 `do_` 作为前缀。

  <sup>[[link](#private-functions-with-same-name-as-public)]</sup>

  ```elixir
  def sum(list), do: do_sum(list, 0)

  # private functions
  defp do_sum([], total), do: total
  defp do_sum([head | tail], total), do: do_sum(tail, head + total)
  ```

### 注释

* <a name="expressive-code"></a>

  编写富有表现力的代码，通过控制流，结构和命名来表达程序的意图。

  <sup>[[link](#expressive-code)]</sup>

* <a name="comment-leading-spaces"></a>

  在注释的 `#` 之后，保留一个空格。

  <sup>[[link](#comment-leading-spaces)]</sup>

  ```elixir
  String.first(some_string) #不好
  String.first(some_string) # 好
  ```

* <a name="comment-grammar"></a>

  一个字以上的注释需要使用正确的英文大小写以及标点符号，并且在句号后添加空格。

  <sup>[[link](#comment-grammar)]</sup>

  ```elixir
  # 不好
  # these lowercase comments are missing punctuation

  # 好
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
  redundant, annotations may be left at the end of the offending line with no
  note.
  This usage should be the exception and not the rule.
  <sup>[[link](#exceptions-to-annotations)]</sup>

  ```elixir
  start_task()
  Process.sleep(5000) # FIXME
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

* <a name="defmodule-spacing"></a>
  Don't put a blank line after `defmodule`.
  <sup>[[link](#defmodule-spacing)]</sup>

* <a name="module-block-spacing"></a>
  Put a blank line after module-level code blocks.
  <sup>[[link](#module-block-spacing)]</sup>

* <a name="module-attribute-ordering"></a>
  List module attributes and directives in the following order:
  <sup>[[link](#module-attribute-ordering)]</sup>

  1. `@moduledoc`
  2. `@behaviour`
  3. `use`
  4. `import`
  5. `alias`
  6. `require`
  7. `defstruct`
  8. `@type`
  9. `@module_attribute`
  10. `@callback`
  11. `@macrocallback`
  12. `@optional_callbacks`

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

  # preferred

  defmodule SomeModule do
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
  If a union type is too long to fit on a single line, add a newline
  and indent with spaces to keep the types aligned.
  <sup>[[link](#union-types)]</sup>

  ```elixir
  # not preferred - no indentation
  @type long_union_type :: some_type | another_type | some_other_type |
  a_final_type

  # preferred
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
  <sup>[[link](#naming-main-types)]</sup>

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

* <a name="additional-struct-def-lines"></a>
  Indent additional lines of the struct definition, keeping the first keys
  aligned.
  <sup>[[link](#additional-struct-def-lines)]</sup>

  ```elixir
  defstruct foo: "test", bar: true, baz: false,
            qux: false, quux: 1
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

_No guidelines for collections have been added yet._

### Strings

* <a name="strings-matching-with-concatenator"></a>
  Match strings using the string concatenator rather than binary patterns:
  <sup>[[link](#strings-matching-with-concatenator)]</sup>

  ```elixir
  # not preferred
  <<"my"::utf8, _rest>> = "my string"

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
  When writing [ExUnit] assertions, be consistent with the order of the expected
  and actual values under testing.
  Prefer placing the expected result on the right, unless the assertion is a
  pattern match.
  <sup>[[link](#testing-assert-order)]</sup>

  ```elixir
  # preferred - expected result on the right
  assert actual_function(1) == true
  assert actual_function(2) == false

  # not preferred - inconsistent order
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

Here's the [list of people who have kindly contributed][Contributors] to this
project.

<!-- Links -->
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
[Portuguese]: https://github.com/gusaiani/elixir_style_guide/blob/master/README_ptBR.md
[Ruby community style guide]: https://github.com/bbatsov/ruby-style-guide
[Sentence Spacing]: http://en.wikipedia.org/wiki/Sentence_spacing
[Spanish]: https://github.com/albertoalmagro/elixir_style_guide/blob/spanish/README_esES.md
[Stargazers]: https://github.com/christopheradams/elixir_style_guide/stargazers
