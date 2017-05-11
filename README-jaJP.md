# [The Elixir Style Guide][Elixir Style Guide]


## 目次

* __[はじめに](#はじめに)__
* __[このガイドについて](#このガイドについて)__
  * [ソースコードレイアウト](#ソースコードレイアウト)
  * [構文](#構文)
  * [命名](#命名)
  * [コメント](#コメント)
      * [注釈](#注釈)
  * [モジュール](#モジュール)
  * [ドキュメント](#ドキュメント)
  * [Typespecs](#typespecs)
  * [構造体](#構造体)
  * [例外](#例外)
  * _コレクション_
  * [文字列](#文字列)
  * _正規表現_
  * [メタプログラミング](#メタプログラミング)
  * [その他のスタイル](#その他のスタイル)
  * [スタイルガイド](#スタイルガイド)
  * [ツール](#ツール)
* __[Getting Involved](#getting-involved)__
  * [Contributing](#contributing)
  * [Spread the Word](#spread-the-word)
* __[Copying](#copying)__
  * [License](#license)
  * [Attribution](#attribution)


## はじめに
> まるでジャズみたいに一緒に即興で演奏するんだ。
> 私が何かを作って、彼らも何かを作ることで答える

> -フランク・ゲーリー

スタイルは重要です。 [Elixir] には実に様々なスタイルがありますが、他の言語と同じように無視されがちです。 
スタイルを尊重しましょう。


## このガイドについて

これは、プログラミング言語　[Elixir] のコミュニティスタイルガイドを作ろうという試みです。気軽にプルリクエストを送ってください。
実際より５倍も長生きしている言語のようにElixirのコミュニティを活発にしましょう。

もし他に貢献できるプロジェクトを探しているなら[Hex package manager site][Hex]を見てみてください。

<a name="translations"></a>
このガイドは以下の言語にも翻訳されています。

* [Chinese Traditional]
* [Japanese]
* [Korean]

### ソースコードのレイアウト

<!-- TODO: Add crafty quote here -->

* <a name="spaces-indentation"></a>
  インデントは **スペース** 2つ。ハードタブは使わないこと。

  <sup>[[link](#spaces-indentation)]</sup>

  ```elixir
  # 悪い例 - スペースが4つ
  def some_function do
      do_something
  end

  # 良い例
  def some_function do
    do_something
  end
  ```

* <a name="line-endings"></a>
  Unixスタイルの改行コードを使うこと (\*BSD/Solaris/Linux/OSX ではこれがデフォルトです Windowsを使っている場合は気をつけてください)
  <sup>[[link](#line-endings)]</sup>

* <a name="autocrlf"></a>
  Gitを使っている場合はwindowsの改行コードであなたのプロジェクトがめちゃくちゃになるのを防ぐために、このように設定してください。  
  <sup>[[link](#autocrlf)]</sup>

  ```sh
  git config --global core.autocrlf true
  ```

* <a name="spaces"></a>
  - オペレータの前後、カンマ、コロン、セミコロンの後にはスペースを入れてください。
  - ()や[]の間にはスペースを入れないでください。
  - Elixirの処理系にとって空白にほとんど意味はありませんが、コードを読みやすくするためには重要です。
  <sup>[[link](#spaces)]</sup>

  ```elixir
  sum = 1 + 2
  {a, b} = {2, 3}
  Enum.map(["one", <<"two">>, "three"], fn num -> IO.puts num end)
  ```

* <a name="def-spacing"></a>
  `def`の間や関数内のロジックの区切りに空白行を入れてください。
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
  関数節に一行の`def`があるならまとめて定義してしまってもよい。
  <sup>[[link](#single-line-defs)]</sup>

  ```elixir
  def some_function(nil), do: {:err, "No Value"}
  def some_function([]), do: :ok
  def some_function([first|rest]) do
    some_function(rest)
  end
  ```

* <a name="long-dos"></a>
`do:`を使った関数定義が長くなった場合は、改行後インデントしてから`do:`を入れてください。
  <sup>[[link](#long-dos)]</sup>

  ```elixir
  def some_function(args),
    do: Enum.map(args, fn(arg) -> arg <> " is on a very long line!" end)
  ```

　上記の規約を使用した関数節があり、かつ他に`do:`を使った関数節がある場合は
  すべての関数節で改行してから `do：`を入れてください：

  ```elixir
  # 悪い例
  def some_function([]), do: :empty
  def some_function(_),
    do: :very_long_line_here

  # 良い例
  def some_function([]),
    do: :empty
  def some_function(_),
    do: :very_long_line_here
  ```

* <a name="multiple-function-defs"></a>
  複数行の関数節が一つ以上ある場合は一行の`def`を使わないこと。
  <sup>[[link](#multiple-function-defs)]</sup>

  ```elixir
  def some_function(nil) do
    {:err, "No Value"}
  end

  def some_function([]) do
    :ok
  end

  def some_function([first|rest]) do
    some_function(rest)
  end

  def some_function([first|rest], opts) do
    some_function(rest, opts)
  end
  ```

* <a name="pipe-operator"></a>
  関数のチェインにはパイプライン演算子を使ってください。
  <sup>[[link](#pipe-operator)]</sup>

  ```elixir
  # 悪い例
  String.strip(String.downcase(some_string))

  # 良い例
  some_string |> String.downcase |> String.strip

  # 複数行のパイプラインはインデントしないこと。
  some_string
  |> String.downcase
  |> String.strip

  # パターンマッチの右辺として複数行のパイプラインを使う場合は改行してから書くこと。
  sanitized_string =
    some_string
    |> String.downcase
    |> String.strip
  ```

  これは好ましい書き方ですが少し注意が必要です。
  IExが次の行にパイプラインがあることを認識せずに最初の行を評価するため、複数行のパイプラインをIExにコピーすると構文エラーが発生する可能性があります。


* <a name="avoid-single-pipelines"></a>

  パイプライン演算子を一度だけ使うのをやめましょう。
  <sup>[[link](#avoid-single-pipelines)]</sup>

  ```elixir
  # 悪い例
  some_string |> String.downcase

  # 良い例
  String.downcase(some_string)
  ```

* <a name="bare-variables"></a>
  関数チェインの最初の値は関数の戻り値ではなく、通常の変数を使ってください。
  <sup>[[link](#bare-variables)]</sup>

  ```elixir
  # これは最悪!
  #  String.strip("nope" |> String.downcase).にパースされます
  String.strip "nope" |> String.downcase

  # 悪い例
  String.strip(some_string) |> String.downcase |> String.codepoints

  # 良い例
  some_string |> String.strip |> String.downcase |> String.codepoints
  ```

* <a name="trailing-whitespace"></a>
  行末に余分な空白を入れないこと。
  <sup>[[link](#trailing-whitespace)]</sup>

* <a name="newline-eof"></a>
  ファイルの終わりには空行をいれること。
  <sup>[[link](#newline-eof)]</sup>


### シンタックス

* <a name="parentheses"></a>
   `def` が引数をとる場合は括弧を使うこと。引数がない場合は省略すること。
  <sup>[[link](#parentheses)]</sup>

  ```elixir
  # 悪い例
  def some_function arg1, arg2 do
    # body omitted
  end

  def some_function() do
    # body omitted
  end

  # 良い例
  def some_function(arg1, arg2) do
    # body omitted
  end

  def some_function do
    # body omitted
  end
  ```

* <a name="do-with-multi-line-if-unless"></a>
  複数行の`if/unless`に `do:`を使ってはいけない。
  <sup>[[link](#do-with-multi-line-if-unless)]</sup>

  ```elixir
  # 悪い例
  if some_condition, do:
    # a line of code
    # another line of code
    # note no end in this block

  # 良い例
  if some_condition do
    # some
    # lines
    # of code
  end
  ```

* <a name="do-with-single-line-if-unless"></a>
  一行の`if/unless` には`do:`を使うこと。
  <sup>[[link](#do-with-single-line-if-unless)]</sup>

  ```elixir
  # 良い例
  if some_condition, do: # some_stuff
  ```

* <a name="unless-with-else"></a>
  `unless` に `else`を使ってはいけない。
  正常系が最初に来るように書き直してください。
  <sup>[[link](#unless-with-else)]</sup>

  ```elixir
  # 悪い例
  unless success? do
    IO.puts 'failure'
  else
    IO.puts 'success'
  end

  # 良い例
  if success? do
    IO.puts 'success'
  else
    IO.puts 'failure'
  end
  ```

* <a name="true-as-last-condition"></a>
  `cond`構文の最後の条件は常に`true`を使うこと。
  <sup>[[link](#true-as-last-condition)]</sup>

  ```elixir
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
　関数名と括弧の間にはスペースを入れないこと。
  <sup>[[link](#function-names-with-parentheses)]</sup>

  ```elixir
  # 悪い例
  f (3 + 2) + 1

  # 良い例
  f(3 + 2) + 1
  ```

* <a name="function-calls-and-parentheses"></a>
　関数呼び出しには括弧を使うこと。特にパイプライン演算子の中では必ず使うこと。
  <sup>[[link](#function-calls-and-parentheses)]</sup>

  ```elixir
  # 悪い例
  f 3

  # 良い例
  f(3)

  # 悪い例.  rem(2, (3 |> g)) にパースされてしまう
  2 |> rem 3 |> g

  # 良い例
  2 |> rem(3) |> g
  ```

* <a name="macro-calls-and-parentheses"></a>
  `do`ブロックをとるマクロの呼び出しでは括弧を省略すること。
  <sup>[[link](#macro-calls-and-parentheses)]</sup>

  ```elixir
  # 悪い例
  quote(do
    foo
  end)

  # 良い例
  quote do
    foo
  end
  ```

* <a name="parentheses-and-function-expressions"></a>
  引数の最後が関数の場合は括弧を省略してもよい。
  <sup>[[link](#parentheses-and-function-expressions)]</sup>

  ```elixir
  # 良い例
  Enum.reduce(1..10, 0, fn x, acc ->
    x + acc
  end)

  # これも良い例
  Enum.reduce 1..10, 0, fn x, acc ->
    x + acc
  end
  ```

* <a name="parentheses-and-functions-with-zero-arity"></a>
  変数と区別するため引数がない関数呼び出しでも括弧を使うこと。
  (Elixir 1.4からは、このようなあいまいな記述があった場合には警告を出すようになりました)
  <sup>[[link](#parentheses-and-functions-with-zero-arity)]</sup>

  ```elixir
  defp do_stuff, do: ...

  # 悪い例
  def my_func do
    do_stuff # 関数呼び出しなのか変数なのかわからない
  end

  # 良い例
  def my_func do
    do_stuff() # 間違いなく関数呼び出し
  end
  ```

* <a name="with-clauses"></a>
  連続した`with`節はインデントを揃え、引数の`do:`を新しい行に入れてください。
  <sup>[[link](#with-clauses)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, bar} <- fetch(opts, :bar),
    do: {:ok, foo, bar}
  ```

* <a name="with-else"></a>
　`with` に 複数行の`do`ブロックがある場合や、`else`オプションがある場合は複数行の構文を使用してください。
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
  アトム、関数、変数には `snake_case` を使うこと。
  <sup>[[link](#snake-case)]</sup>

  ```elixir
  # 悪い例
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

  # 良い例
  :some_atom

  some_var = 5

  def some_function do
    ...
  end
  ```

* <a name="camel-case"></a>
  モジュール名は`CamelCase`を使うこと(HTTP, RFC, XMLなどの頭地語はそのままでよい)
  <sup>[[link](#camel-case)]</sup>

  ```elixir
  # 悪い例
  defmodule Somemodule do
    ...
  end

  defmodule Some_Module do
    ...
  end

  defmodule SomeXml do
    ...
  end

  # 良い例
  defmodule SomeModule do
    ...
  end

  defmodule SomeXML do
    ...
  end
  ```

* <a name="predicate-macro-names-with-guards"></a>
  ガード内で使用できる述語マクロ（コンパイル時にbooleanを返す関数になるもの）には`is_`接頭辞をつけること。
  ガード内で使用できる式については [Expressions in Guard Clauses](http://elixir-lang.org/getting-started/case-cond-and-if.html#expressions-in-guard-clauses)を参照してください。
  <sup>[[link](#predicate-macro-names-with-guards)]</sup>

  ```elixir
  defmacro is_cool(var) do
    quote do: unquote(var) == "cool"
  end
  ```

* <a name="predicate-macro-names-no-guards"></a>
  ガード内で使わない述語関数は`is_`接頭辞ではなく末尾に`?`をつけること。
  <sup>[[link](#predicate-macro-names-no-guards)]</sup>

  ```elixir
  def cool?(var) do
    # Complex check if var is cool not possible in a pure function.
  end
  ```

* <a name="private-functions-with-same-name-as-public"></a>
  パブリック関数と同名のプライベート関数を定義したい場合は`do_`を頭につけること。
  <sup>[[link](#private-functions-with-same-name-as-public)]</sup>

  ```elixir
  def sum(list), do: do_sum(list, 0)

  # private functions
  defp do_sum([], total), do: total
  defp do_sum([head|tail], total), do: do_sum(tail, head + total)
  ```


### コメント

* <a name="self-documenting-code"></a>
  表現力豊かなコードを書いてください。 制御フロー、構造、命名を通じてプログラムの意図を伝えてください。
  <sup>[[link](#self-documenting-code)]</sup>

* <a name="comment-leading-spaces"></a>
  `#` とコメントの間にスペースを一つ入れること。
  <sup>[[link](#comment-leading-spaces)]</sup>

* <a name="comment-spacing"></a>
  一語以上のコメントは先頭を大文字にして句読点を使うこと。
  ピリオドの後には[スペースを一つ](http://en.wikipedia.org/wiki/Sentence_spacing)入れること。
  <sup>[[link](#comment-spacing)]</sup>

  ```elixir
  # 悪い例
  String.upcase(some_string) # Capitalize string.
  ```

#### 注釈

* <a name="annotations"></a>
  注釈は関連するコードのすぐ上に書くこと。
  <sup>[[link](#annotations)]</sup>

* <a name="annotation-keyword"></a>
  注釈キーワードの後には: とスペースを入れてから本文を書いてください。
  <sup>[[link](#annotation-keyword)]</sup>

* <a name="multiple-line-annotations"></a>
  もし問題の説明が複数行になる場合は#の後にスペースを２つ入れてください。
  <sup>[[link](#multiple-line-annotations)]</sup>

* <a name="exceptions-to-annotations"></a>
  もし問題が明らかな場合は注釈キーワードだけを該当行の最後に入れてください。
  これは強制ではありません。
  <sup>[[link](#exceptions-to-annotations)]</sup>

* <a name="todo-notes"></a>
  未実装や、将来の機能追加のための注釈には`TODO`を使ってください。
  <sup>[[link](#todo-notes)]</sup>

* <a name="fixme-notes"></a>
  壊れたコードの注釈には `FIXME` を使ってください。
  <sup>[[link](#fixme-notes)]</sup>

* <a name="optimize-notes"></a>
  遅かったり、非効率的なコードの注釈には`OPTIMIZE` を使ってください。
  <sup>[[link](#optimize-notes)]</sup>

* <a name="hack-notes"></a>
  コードの書き方に疑問の残る箇所の注釈には`HACK`を使ってください。
  <sup>[[link](#hack-notes)]</sup>

* <a name="review-notes"></a>
  正しく動くか確認する必要があるコードの注釈には `REVIEW` を使ってください。
  例: `REVIEW: Are we sure this is how the client does X currently?`
  <sup>[[link](#review-notes)]</sup>

* <a name="custom-keywords"></a>
  もし必要があるようなら独自の注釈キーワードを使ってもかまいませんが、それらはプロジェクトの `README` などに書かれるべきでしょう。
  <sup>[[link](#custom-keywords)]</sup>


### モジュール

* <a name="one-module-per-file"></a>
  モジュールは一つのファイルに一つだけ定義すること。
  ただし内部的にのみ使用しているモジュール（テストなど) の場合はこの限りではない。
  <sup>[[link](#one-module-per-file)]</sup>

* <a name="underscored-filenames"></a>
  キャメルケースのモジュール名をアンダースコア化したファイル名にすること。
  <sup>[[link](#underscored-filenames)]</sup>

  ```elixir
  # file is called some_module.ex

  defmodule SomeModule do
  end
  ```

* <a name="module-name-nesting"></a>
  モジュール名のネストはディレクトリ構造を反映させること。
  <sup>[[link](#module-name-nesting)]</sup>

  ```elixir
  # file is called parser/core/xml_parser.ex

  defmodule Parser.Core.XMLParser do
  end
  ```

* <a name="defmodule-spacing"></a>
  `defmodule`の後に空行を開けてはいけない。
  <sup>[[link](#defmodule-spacing)]</sup>

* <a name="module-block-spacing"></a>
  モジュールレベルのコードブロックの後には空行を入れること。
  <sup>[[link](#module-block-spacing)]</sup>

* <a name="module-attribute-ordering"></a>
  モジュール内の定義順は下記のようにする。
  <sup>[[link](#module-attribute-ordering)]</sup>

  1. `@moduledoc`
  1. `@behaviour`
  1. `use`
  1. `import`
  1. `alias`
  1. `require`
  1. `defstruct`
  1. `@type`
  1. `@module_attribute`

  それぞれのグループの間には空白行を入れ、アルファベット順でソートしてください。
  モジュール定義の例を以下に記します。

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
    alias My.Other.Module.Name

    require Integer

    defstruct name: nil, params: []

    @type params :: [{binary, binary}]

    @module_attribute :foo
    @other_attribute 100

    ...
  end
  ```

* <a name="module-pseudo-variable"></a>
  モジュールが自身を参照するには`__MODULE__`疑似変数を使用すること。
  これならモジュール名が変更されてもコードの変更が要りません。
  <sup>[[link](#module-pseudo-variable)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    defstruct [:name]

    def name(%__MODULE__{name: name}), do: name
  end
  ```

* <a name="alias-self-referencing-modules"></a>
  もしモジュール自身の参照にもっとわかりやすい名前を使いたければaliasを使うことができます。
  <sup>[[link](#alias-self-referencing-modules)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    alias __MODULE__, as: SomeModule

    defstruct [:name]

    def name(%SomeModule{name: name}), do: name
  end
  ```


### ドキュメント
  Elixrのドキュメント(`iex`の中で`h`を入力するか、[ExDoc](https://github.com/elixir-lang/ex_doc)で作られたもの) はモジュールアトリビュート [Module Attributes](\
  http://elixir-lang.org/getting-started/module-attributes.html#as-annotations) `@moduledoc` と `@doc`を使います。

* <a name="moduledocs"></a>
  `@moduledoc` は必ず`defmodule`の次の行に書くこと。
  <sup>[[link](#moduledocs)]</sup>

  ```elixir
  # 悪い例

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

  # 良い例

  defmodule SomeModule do
    @moduledoc """
    About the module
    """
    ...
  end
  ```

* <a name="moduledoc-false"></a>
  モジュールについてのドキュメントを書かない場合は `@moduledoc false`を使ってください。
  <sup>[[link](#moduledoc-false)]</sup>

  ```elixir
  defmodule SomeModule do
    @moduledoc false
    ...
  end
  ```

* <a name="moduledoc-spacing"></a>
  `@moduledoc`の後には空白行を開けてください。
  <sup>[[link](#moduledoc-spacing)]</sup>

  ```elixir
  # 悪い例

  defmodule SomeModule do
    @moduledoc """
    About the module
    """
    use AnotherModule
  end

  # 良い例
  defmodule SomeModule do
    @moduledoc """
    About the module
    """

    use AnotherModule
  end
  ```

* <a name="heredocs"></a>
  ドキュメントのため、複数行コメント内ではmarkdownを使いましょう。
  <sup>[[link](#heredocs)]</sup>

  ```elixir
  # 悪い例

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

  # 良い例
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

typespecsは、型と仕様を宣言するための表記法です。
ドキュメント、または静的解析ツールDialyzerに使用されます。
カスタムタイプは、モジュール上部に他のタイプと一緒に定義する必要があります。
([モジュール](#modules)をみてください).

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
  直和型の定義が長過ぎる場合は改行して戻り値の型で整列するようにインデントしてください。
  <sup>[[link](#union-types)]</sup>

  ```elixir
  # 悪い例 - インデントしていない
  @type long_union_type :: some_type | another_type | some_other_type
  | a_final_type

  # 良い例
  @type long_union_type :: some_type | another_type | some_other_type
                         | a_final_type

  # これも良い例 - 一行ごとに型一つ
  @type long_union_type :: some_type
                         | another_type
                         | some_other_type
                         | a_final_type
  ```

* <a name="naming-main-types"></a>
  モジュール内で定義された構造体などの型定義は `t`としてください。
  <sup>[[link](#naming-main-types)]</sup>

  ```elixir
  defstruct name: nil, params: []

  @type t :: %__MODULE__{
    name: String.t,
    params: Keyword.t
  }
  ```

* <a name="spec-spacing"></a>
  型定義は関数のすぐ上に空白行無しで書いてください。
  <sup>[[link](#spec-spacing)]</sup>

  ```elixir
  @spec some_function(term) :: result
  def some_function(some_data) do
    {:ok, some_data}
  end
  ```


### 構造体

* <a name="nil-struct-field-defaults"></a>
  もし構造体のフィールドのデフォルト値が全てnilならアトムのリストとしてください。
  <sup>[[link](#nil-struct-field-defaults)]</sup>

  ```elixir
  # 悪い例
  defstruct name: nil, params: nil

  # 良い例
  defstruct [:name, :params]
  ```

* <a name="additional-struct-def-lines"></a>
  複数行に渡る構造体の定義の場合は、最初のキーの位置に合わせてインデントしてください。
  <sup>[[link](#additional-struct-def-lines)]</sup>

  ```elixir
  defstruct foo: "test", bar: true, baz: false,
            qux: false, quux: nil
  ```


### 例外

* <a name="exception-names"></a>
  例外の名前は`Error`で終わること。
  [[link](#exception-names)]</sup>

  ```elixir
  # 悪い例
  defmodule BadHTTPCode do
    defexception [:message]
  end

  defmodule BadHTTPCodeException do
    defexception [:message]
  end

  # 良い例
  defmodule BadHTTPCodeError do
    defexception [:message]
  end
  ```

* <a name="lowercase-error-messages"></a>
  エラーメッセージは小文字で句読点を省いてください
  <sup>[[link](#lowercase-error-messages)]</sup>

  ```elixir
  # 悪い例
  raise ArgumentError, "This is not valid."

  # 良い例
  raise ArgumentError, "this is not valid"
  ```


### コレクション

_コレクションに関するガイドラインは今のところありません_


### 文字列

* <a name="strings-matching-with-concatenator"></a>
文字列のパターンマッチはバイナリではなく、文字列結合演算子を使用してください。
  <sup>[[link](#strings-matching-with-concatenator)]</sup>

  ```elixir
  # 悪い例
  <<"my"::utf8, _rest>> = "my string"

  # 良い例
  "my" <> _rest = "my string"
  ```


### 正規表現

_正規表現に関するガイドラインは今のところありません_


### メタプログラミング

* <a name="avoid-metaprogramming"></a>
  不要なメタプログラミングをしてはいけない。
  <sup>[[link](#avoid-metaprogramming)]</sup>


### その他のスタイル

あまり一般的ではないスタイルですが役立つ場合があるかもしれません。

#### Cond

* <a name="atom-conditions"></a>
  アトムは`true`として評価されるので`cond`の最後に入れるすべてにマッチする節として使うことができます。
  `:else` か `:otherwise` を使うと良いでしょう。
  <sup>[[link](#atom-conditions)]</sup>

  ```elixir
  cond do
    1 + 2 == 5 ->
      "Nope"
    1 + 3 == 5 ->
      "Uh, uh"
    :else ->
      "OK"
  end

  # is the same as
  cond do
    1 + 2 == 5 ->
      "Nope"
    1 + 3 == 5 ->
      "Uh, uh"
    true ->
      "OK"
  end
  ```


### スタイルガイド

他のスタイルガイドについては [Awesome Elixir][Style Guides] を見てください。


### Tools

[Awesome Elixir][Code Analysis] にコードの静的解析とlintのためのツールがあります

## Getting Involved


### コントリビュート

私達はここがElixirのベストプラクティスに関する議論の中心になることを願っています。
気軽にイシューを書いたりプルリクエストを送ってください。
[contributing guidelines](CONTRIBUTING.md)と [code of conduct](CODE_OF_CONDUCT.md) を確認してください。


### Spread the Word
コミュニティスタイルガイドは、コミュニティのサポートなしでは無意味です。
ツイートしたり、スターをつけたり、Elixirプログラマに広めてください。


## Copying


### License

![Creative Commons License](http://i.creativecommons.org/l/by/3.0/88x31.png)
This work is licensed under a
[Creative Commons Attribution 3.0 Unported License][license]


### Attribution

The structure of this guide, bits of example code, and many of the initial
points made in this document were borrowed from the [Ruby community style guide].
A lot of things were applicable to Elixir and allowed us to get _some_ document
out quicker to start the conversation.

Here's the [list of people who has kindly contributed][Contributors] to this
project.

<!-- Links -->
[Chinese Traditional]: https://github.com/elixirtw/elixir_style_guide/blob/master/README_zhTW.md
[Elixir Style Guide]: https://github.com/christopheradams/elixir_style_guide
[Stargazers]: https://github.com/christopheradams/elixir_style_guide/stargazers
[Contributors]: https://github.com/christopheradams/elixir_style_guide/graphs/contributors
[Elixir]: http://elixir-lang.org
[Hex]: https://hex.pm/packages
[Japanese]: https://github.com/kenichirow/elixir_style_guide/blob/master/README-jaJP.md
[Korean]: https://github.com/marocchino/elixir_style_guide/blob/new-korean/README-koKR.md
[license]: http://creativecommons.org/licenses/by/3.0/deed.en_US
[Ruby community style guide]: https://github.com/bbatsov/ruby-style-guide
[Code Analysis]: https://github.com/h4cc/awesome-elixir#code-analysis
[Style Guides]: https://github.com/h4cc/awesome-elixir#styleguides
