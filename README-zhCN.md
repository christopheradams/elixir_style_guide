# [The Elixir Style Guide][Elixir Style Guide]

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

#### 注解

* <a name="annotations"></a>

  注解通常写在相关代码的上一行。

  <sup>[[link](#annotations)]</sup>

* <a name="annotation-keyword"></a>

  注解关键字要大写，紧接着是一个冒号和一个空格，然后是问题的描述。

  <sup>[[link](#annotation-keyword)]</sup>

  ```elixir
  # TODO: Deprecate in v1.5.
  def some_function(arg), do: {:ok, arg}
  ```

* <a name="exceptions-to-annotations"></a>

  在问题显而易见的情况下，任何说明都是多余的，注解要放到代码的最后并且不带任何解释。

  这个用法是特例而不是规则。

  <sup>[[link](#exceptions-to-annotations)]</sup>

  ```elixir
  start_task()
  Process.sleep(5000) # FIXME
  ```

* <a name="todo-notes"></a>

  使用 `TODO` 来标记未来要实现功能或特性。

  <sup>[[link](#todo-notes)]</sup>

* <a name="fixme-notes"></a>

  使用 `FIXME` 来标记要被修复的代码。

  <sup>[[link](#fixme-notes)]</sup>

* <a name="optimize-notes"></a>

  使用 `OPTIMIZE` 来标记可能会引起性能问题的缓慢或者低效的代码。

  <sup>[[link](#optimize-notes)]</sup>

* <a name="hack-notes"></a>

  使用 `HACK` 来比较代码中的坏味道，这些有问题的编码实践应当被重构。

  <sup>[[link](#hack-notes)]</sup>

* <a name="review-notes"></a>

  使用 `REVIEW` 来标记需要确认是否正常工作的地方。

  例如: `REVIEW: Are we sure this is how the client does X currently?`
  <sup>[[link](#review-notes)]</sup>

* <a name="custom-keywords"></a>

  如果你觉得需要的话，使用其他自定义的关键字，并将它们记录到 `README` 或者其他类似的文档中。

  <sup>[[link](#custom-keywords)]</sup>

### 模块

* <a name="one-module-per-file"></a>

  每个源文件内只有一个模块，除非模块只在另一个模块内部使用 (例如测试)。

  <sup>[[link](#one-module-per-file)]</sup>

* <a name="underscored-filenames"></a>

  文件名使用 `蛇底式` (`snake_case`)，模块名使用 `驼峰式` (`CamelCase`)。

  <sup>[[link](#underscored-filenames)]</sup>

  ```elixir
  # file is called some_module.ex

  defmodule SomeModule do
  end
  ```

* <a name="module-name-nesting"></a>

  嵌套模块命名中的每一层代表一层文件夹。

  <sup>[[link](#module-name-nesting)]</sup>

  ```elixir
  # file is called parser/core/xml_parser.ex

  defmodule Parser.Core.XMLParser do
  end
  ```

* <a name="defmodule-spacing"></a>

  `defmodule` 之后不要添加空行。

  <sup>[[link](#defmodule-spacing)]</sup>

* <a name="module-block-spacing"></a>

  模块代码之后添加空行。

  <sup>[[link](#module-block-spacing)]</sup>

* <a name="module-attribute-ordering"></a>

  模块属性和指令要按照下面的顺序：

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

  在每一组属性或者指令后加入空行，并且本组的项目 (例如，模块名) 要按照字母排序。

  这里有一个完整的例子：

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
  当模块引用自身时使用 `__MODULE__` 伪变量。

  如果模块名称修改，可以避免更新对模块自身的引用。

  <sup>[[link](#module-pseudo-variable)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    defstruct [:name]

    def name(%__MODULE__{name: name}), do: name
  end
  ```

* <a name="alias-self-referencing-modules"></a>

  设置一个别名，可以让模块名更具可读性。

  <sup>[[link](#alias-self-referencing-modules)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    alias __MODULE__, as: SomeModule

    defstruct [:name]

    def name(%SomeModule{name: name}), do: name
  end
  ```

* <a name="repetitive-module-names"></a>
  避免在模块名和命名空间中使用重复的名称，这样提高可读性并且消除 [ambiguous aliases][Conflicting Aliases]。

  <sup>[[link](#repetitive-module-names)]</sup>

  ```elixir
  # 不好
  defmodule Todo.Todo do
    ...
  end

  # 好
  defmodule Todo.Item do
    ...
  end
  ```

### 文档

使用模块变量 (Module Attributes) `@moduledoc` 和 `@doc` 声明文档 (在 `iex` 使用 `h`查看或者使用 [ExDoc] 生成)。

* <a name="moduledocs"></a>

  在 `defmodule` 之后下一行总是定义 `@moduledoc` 变量。

  <sup>[[link](#moduledocs)]</sup>

  ```elixir
  # 不好

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

  # 好

  defmodule SomeModule do
    @moduledoc """
    About the module
    """
    ...
  end
  ```

* <a name="moduledoc-false"></a>

  使用 `@moduledoc false`，如果你不想为这个模块增加文档。

  <sup>[[link](#moduledoc-false)]</sup>

  ```elixir
  defmodule SomeModule do
    @moduledoc false
    ...
  end
  ```

* <a name="moduledoc-spacing"></a>

  `@moduledoc` 之后添加一个空行，与其他代码分开。

  <sup>[[link](#moduledoc-spacing)]</sup>

  ```elixir
  # 不好

  defmodule SomeModule do
    @moduledoc """
    About the module
    """
    use AnotherModule
  end

  # 好
  defmodule SomeModule do
    @moduledoc """
    About the module
    """

    use AnotherModule
  end
  ```

* <a name="heredocs"></a>

  在文档内使用 `heredocs` 和 `markdown`。

  <sup>[[link](#heredocs)]</sup>

  ```elixir
  # 不好

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

  # 好
  defmodule SomeModule do
    @moduledoc """
    About the module

    ## Examples

        iex> SomeModule.some_function
        :result
    """
  end
  ```

### 类型声明 (Typespecs)

Typespecs是用于声明类型和规格的符号，主要用于文档或是静态分析工具，例如 Dialyzer。

自定义类型应当与其他指令一起位于模块的顶部。 (详见 [模块](#modules)).

* <a name="typedocs"></a>

  同时使用 `@typedoc` 和 `@type`，并且每对之间使用空行间隔。

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

  如果联合类型 (union type) 声明超过一行，增加新的一行并且使用空格缩进，保持类型对齐。

  <sup>[[link](#union-types)]</sup>

  ```elixir
  # 不好 - 没有缩进
  @type long_union_type :: some_type | another_type | some_other_type |
  a_final_type

  # 好
  @type long_union_type :: some_type | another_type | some_other_type |
                           a_final_type

  # 同样好 - 每一个类型单独一行
  @type long_union_type :: some_type |
                           another_type |
                           some_other_type |
                           a_final_type
  ```

* <a name="naming-main-types"></a>

  模块的主类型命名为 `t`，例子：结构的类型声明。

  <sup>[[link](#naming-main-types)]</sup>

  ```elixir
  defstruct name: nil, params: []

  @type t :: %__MODULE__{
    name: String.t | nil,
    params: Keyword.t
  }
  ```

* <a name="spec-spacing"></a>

  将函数的类型声明放到函数定义之上，不用空行间隔。

  <sup>[[link](#spec-spacing)]</sup>

  ```elixir
  @spec some_function(term) :: result
  def some_function(some_data) do
    {:ok, some_data}
  end
  ```

### 结构

* <a name="nil-struct-field-defaults"></a>
  默认值为 `nil` 的结构字段使用原子符号列表 (list of atoms)，后面紧跟着其他关键字。

  <sup>[[link](#nil-struct-field-defaults)]</sup>

  ```elixir
  # 不好
  defstruct name: nil, params: nil, active: true

  # 好
  defstruct [:name, :params, active: true]
  ```

* <a name="struct-def-brackets"></a>

  如果 `defstruct` 的参数是关键字列表 (keyword list)，则省略括号。

  <sup>[[link](#struct-def-brackets)]</sup>

  ```elixir
  # 不好
  defstruct [params: [], active: true]

  # 好
  defstruct params: [], active: true

  # 必须 - 由于至少有一个原子符号，括号不可以省略
  defstruct [:name, params: [], active: true]
  ```

* <a name="additional-struct-def-lines"></a>

  如果结构定义是多行，保持每行第一个键缩进对齐。

  <sup>[[link](#additional-struct-def-lines)]</sup>

  ```elixir
  defstruct foo: "test", bar: true, baz: false,
            qux: false, quux: 1
  ```

### 异常

* <a name="exception-names"></a>

  异常的命名以 `Error` 结尾。

  <sup>[[link](#exception-names)]</sup>

  ```elixir
  # 不好
  defmodule BadHTTPCode do
    defexception [:message]
  end

  defmodule BadHTTPCodeException do
    defexception [:message]
  end

  # 好
  defmodule BadHTTPCodeError do
    defexception [:message]
  end
  ```

* <a name="lowercase-error-messages"></a>

  抛出异常时，异常信息使用小写，并且最后不需要添加标点符号。

  <sup>[[link](#lowercase-error-messages)]</sup>

  ```elixir
  # 不好
  raise ArgumentError, "This is not valid."

  # 好
  raise ArgumentError, "this is not valid"
  ```

### 集合

暂无内容。

### 字符串

* <a name="strings-matching-with-concatenator"></a>

  字符串进行模式匹配时，使用字符串拼接的方式而不要使用二进制的方式。

  <sup>[[link](#strings-matching-with-concatenator)]</sup>

  ```elixir
  # 不好
  <<"my"::utf8, _rest>> = "my string"

  # 好
  "my" <> _rest = "my string"
  ```

### 正则表达式

暂无内容。

### 元编程 (metaprogramming)

* <a name="avoid-metaprogramming"></a>
  避免不必要的元编程。
  <sup>[[link](#avoid-metaprogramming)]</sup>

### 测试

* <a name="testing-assert-order"></a>

  在编写 [ExUnit] 断言 (assertions) 时，保持预期值和测试值顺序的一致性。

  尽量把预期值放在右边，除非这条断言在进行模式匹配。

  <sup>[[link](#testing-assert-order)]</sup>

  ```elixir
  # 好 - 预期值在右边
  assert actual_function(1) == true
  assert actual_function(2) == false

  # 不好 - 顺序不一致
  assert actual_function(1) == true
  assert false == actual_function(2)

  # 必要 - 断言是模式匹配
  assert {:ok, expected} = actual_function(3)
  ```

### 更多风格指南

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

### 工具

参考 [Awesome Elixir][Code Analysis] 来了解可以帮助代码分析的库和工具。

## 参与

### 贡献

我们希望这将成为社区讨论 Elixir 最佳实践的中心。

欢迎发起讨论或提交一个带有改进性质的更新请求。在此提前感谢你的帮助！

参考 [contributing guidelines][Contributing]
和 [code of conduct][Code Of Conduct] 获得更多信息。

### 口耳相传

一份社区驱动的风格指南，如果没多少人知道， 对一个社区来说就没有多少用处。

请转发，关注这份指南，让每一个 Elixir 程序员都知晓这份指南，让每一个 Elixir 程序员都可以贡献这份指南！

## 授权

### License

![Creative Commons License](http://i.creativecommons.org/l/by/3.0/88x31.png)
本指南基于
[Creative Commons Attribution 3.0 Unported License][License] 授权许可。
