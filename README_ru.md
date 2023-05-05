# [Руководство по стилю Elixir][Elixir Style Guide]

## Оглавление

- **[Введение](#введение)**
- **[Описание](#описание)**
- **[Форматирование](#форматирование)**
  - [Пробелы](#пробелы)
  - [Отступы](#отступы)
  - [Скобки](#скобки)
- **[Руководство](#руководство)**
  - [Выражения](#выражения)
  - [Именование](#именование)
  - [Комментарии](#комментарии)
    - [Аннотации](#комментарии-аннотации)
  - [Модули](#модули)
  - [Документация](#документация)
  - [Аннотации типов](#аннотации-типов)
  - [Структуры (Structs)](#structs)
  - [Исключения](#исключения)
  - [Коллекции](#коллекции)
  - [Строки](#строки)
  - _Регулярные выражения_
  - [Метапрограммирование](#метапрограммирование)
  - [Тестирование](#тестирование)
- **[Ресурсы](#ресурсы)**
  - [Альтернативные руководства по стилю](#альтернативные-руководства-по-стилю)
  - [Инструменты](#инструменты)
- **[Участие](#участие)**
  - [Вклад](#вклад)
  - [Распространение](#распространение)
- **[Копирование](#копирование)**
  - [Лицензия](#лицензия)
  - [Авторство](#авторство)

## Введение

> Жидкая архитектура. Это как джаз - вы импровизируете, работаете вместе, взаимодействуете друг с другом, вы создаете что-то, они создают что-то.
>
> —Френк Гери

Стиль имеет значение. [Elixir] имеет много стилей, но, как и все языки, его можно задушить. Не душите стиль.

## Описание

Это перевод на русский язык руководства по написанию кода от сообщества языка программирования [Elixir][Elixir]. Не стесняйтесь вносить предложения и создавать pull requests, и присоединяйтесь к
живому сообществу Elixir.

Если вы ищете другие проекты, в которые можно внести свой вклад, посетите сайт менеджета пакетов [Hex][Hex].

<a name="translations"></a> Переводы руководства доступны на следующих языках:

- [Упрощенный китайский][Chinese Simplified]
- [Китайский традиционный][Chinese Traditional]
- [французский][French]
- [японский][Japanese]
- [корейский][Korean]
- [португальский][Portuguese]
- [испанский][Spanish]

## Форматирование

В Elixir v1.6 был представлен [форматировщик кода][Code Formatter] и [задача format в Mix][Mix format]. Для всех новых проектов и исходного кода предпочтительнее использовать форматировщик.

Правила, перечисленные в этом разделе, применяются автоматически форматировщиком кода, здесь же они представлены в качестве примеров предпочтительного стиля.

### Пробелы

– <a name="trailing-whitespace"></a> Избегайте пробелов в конце строки. <sup>[[ссылка](#trailing-whitespace)]</sup>

- <a name="newline-eof"></a> Заканчивайте каждый файл пустой строкой. <sup>[[ссылка](#newline-eof)]</sup>

- <a name="line-endings"></a> Используйте символы новой строки в стиле Unix (\*BSD/Solaris/Linux/OSX по умолчанию, пользователи Windows должны быть особенно осторожны).
  <sup>[[ссылка](#line-endings)]</sup>

- <a name="autocrlf"></a> Если вы используете Git, вы можете добавить следующую конфигурационную настройку, чтобы защитить свой проект от появления символов новой строки Windows:
  <sup>[[ссылка](#autocrlf)]</sup>

```sh
  git config --global core.autocrlf true
```

- <a name="line-length"></a> Ограничивайте длину строк 98 символами или установите параметр :line_length в вашем файле .formatter.exs. <sup>[[ссылка](#line-length)]</sup>

- <a name="spaces"></a> Используйте пробелы вокруг операторов, после запятых, двоеточий и точек с запятой. Не ставьте пробелы вокруг парных символов, таких как кавычки, скобки и т.д. Пробелы (в
  основном) несущественны для Elixir во время выполнения, но их правильное использование является ключом к написанию легко читаемого кода. <sup>[[ссылка](#spaces)]</sup>

```elixir
sum = 1 + 2
{a, b} = {2, 3}
[first | rest] = [1, 2, 3]
Enum.map(["one", <<"two">>, "three"], fn num -> IO.puts(num) end)
```

- <a name="no-spaces"></a> Не используйте пробелы после операторов, которые принимают только один аргумент, или вокруг оператора range. <sup>[[ссылка](#no-spaces)]</sup>

  ```elixir
  0 - 1 == -1
  ^pinned = some_func()
  5 in 1..10
  ```

- <a name="def-spacing"></a> Используйте пустые строки между def для разбиения функции на логические параграфы. <sup>[[ссылка](#def-spacing)]</sup>

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

- <a name="defmodule-spacing"></a> Не ставьте пустую строку после defmodule. <sup>[[ссылка](#defmodule-spacing)]</sup>

- <a name="long-dos"></a> Если заголовок функции и do:-клауза слишком длинные и не помещаются на одной строке, поместите do: на новую строку, с отступом на один уровень больше, чем на предыдущей
  строке. <sup>[[ссылка](#long-dos)]</sup>

  ```elixir
  def some_function([:foo, :bar, :baz] = args),
    do: Enum.map(args, fn arg -> arg <> " is on a very long line!" end)
  ```

  Когда do:-клауза начинается с новой строки, следует относиться к ней как к многострочной функции, разделяя её пустыми строками.

  ```elixir
  # нежелательно
  def some_function([]), do: :empty
  def some_function(_),
    do: :very_long_line_here

  # предпочтительно
  def some_function([]), do: :empty

  def some_function(_),
    do: :very_long_line_here
  ```

- <a name="add-blank-line-after-multiline-assignment"></a> Добавьте пустую строку после многострочного присвоения как визуальный критерий того, что присвоение завершено.
  <sup>[[ссылка](#add-blank-line-after-multiline-assignment)]</sup>

  ```elixir
  # нежелательно
  some_string =
    "Hello"
    |> String.downcase()
    |> String.trim()
  another_string <> some_string

  # предпочтительно
  some_string =
    "Hello"
    |> String.downcase()
    |> String.trim()

  another_string <> some_string
  ```

  ```elixir
  # также нежелательно
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end
  String.downcase(something)

  # предпочтительно
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end

  String.downcase(something)
  ```

- <a name="multiline-enums"></a> Если список, ассоциативный массив или структура занимает несколько строк, помещайте каждый элемент, а также открывающую и закрывающую скобки, на отдельных строках.
  Сделайте отступ для содержимого на 1 уровень относительно открывающей и закрывабшей скобки. <sup>[[ссылка](#multiline-enums)]</sup>

  ```elixir
  # нежелательно
  [:first_item, :second_item, :next_item,
  :final_item]

  # предпочтительно
  [
    :first_item,
    :second_item,
    :next_item,
    :final_item
  ]
  ```

- <a name="multiline-list-assign"></a> Когда вы присваиваете список, ассоциативный массив или структуру, поместите открывающую скобку на ту же строку, что и присваивание.
  <sup>[[ссылка](#multiline-list-assign)]</sup>

  ```elixir
  # нежелательно
  list =
  [
    :first_item,
    :second_item
  ]

  # предпочтительно
  list = [
    :first_item,
    :second_item
  ]
  ```

- <a name="multiline-case-clauses"></a> Если любой из клауз case или cond требует более одной строки (из-за длины строки, нескольких выражений в теле клаузы и т.д.), используйте многострочный
  синтаксис для всех клауз и разделяйте их с помощью пустой строки.<sup>[[ссылка](#multiline-case-clauses)]</sup>

  ```elixir
  # нежелательно
  case arg do
    true -> IO.puts("ok"); :ok
    false -> :error
  end

  # нежелательно
  case arg do
    true ->
      IO.puts("ok")
      :ok
    false -> :error
  end

  # предпочтительно
  case arg do
    true ->
      IO.puts("ok")
      :ok

    false ->
      :error
  end
  ```

- <a name="comments-above-line"></a> Размещайте комментарии над строкой, которую они комментируют. <sup>[[ссылка](#comments-above-line)]</sup>

  ```elixir
  String.first(some_string) # нежелательно

  # предпочтительно
  String.first(some_string)
  ```

- <a name="comment-leading-spaces"></a> Используйте один пробел между ведущим символом # комментария и текстом комментария. <sup>[[ссылка](#comment-leading-spaces)]</sup>

  ```elixir
  #not preferred
  String.first(some_string)

  # предпочтительно
  String.first(some_string)
  ```

### Отступы

- <a name="with-clauses"></a> Выравнивайте последовательные with-клаузы и делайте для них одинаковый отступ. Помещайте аргумент do:-клаузы на новую строку, выровненную с предыдущими клаузами.
  <sup>[[ссылка](#with-clauses)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, my_var} <- fetch(opts, :my_var),
       do: {:ok, foo, my_var}
  ```

- <a name="with-else"></a> Если блок with содержит несколько строк или имеет вариант else, используйте многострочный синтаксис. <sup>[[ссылка](#with-else)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, my_var} <- fetch(opts, :my_var) do
    {:ok, foo, my_var}
  else
    :error ->
      {:error, :bad_arg}
  end
  ```

### Скобки

- <a name="parentheses-pipe-operator"></a> Используйте скобки для функций с одним аргументом при использовании оператора конвейера (pipe operator) (|>).
  <sup>[[ссылка](#parentheses-pipe-operator)]</sup>

  ```elixir
  # нежелательно
  some_string |> String.downcase |> String.trim

  # предпочтительно
  some_string |> String.downcase() |> String.trim()
  ```

- <a name="function-names-with-parentheses"></a> Никогда не ставьте пробел между именем функции и открывающей скобкой. <sup>[[ссылка](#function-names-with-parentheses)]</sup>

  ```elixir
  # нежелательно
  f (3 + 2)

  # предпочтительно
  f(3 + 2)
  ```

- <a name="function-calls-and-parentheses"></a> Используйте скобки в вызовах функций, особенно внутри конвейера (pipeline). <sup>[[ссылка](#function-calls-and-parentheses)]</sup>

  ```elixir
  # нежелательно
  f 3

  # предпочтительно
  f(3)

  # нежелательно и читается как rem(2, (3 |> g)), а не как задумано.
  2 |> rem 3 |> g

  # предпочтительно
  2 |> rem(3) |> g()
  ```

- <a name="keyword-list-brackets"></a> Опустите квадратные скобки в ключевых списках, когда они необязательны.<sup>[[ссылка](#keyword-list-brackets)]</sup>

  ```elixir
  # нежелательно
  some_function(foo, bar, [a: "baz", b: "qux"])

  # предпочтительно
  some_function(foo, bar, a: "baz", b: "qux")
  ```

## Руководство

Правила в этом разделе могут не применяться форматировщиком кода автоматически, однако обычно эти правила являются предпочтительной практикой.

### Выражения

- <a name="single-line-defs"></a> Выравнивайте однострочные выражения `def`, которые относятся к одной функции, друг за другом, а многострочные выражения `def` разделяйте пустой строкой.
  <sup>[[ссылка](#single-line-defs)]</sup>

  ```elixir
  def some_function(nil), do: {:error, "No Value"}
  def some_function([]), do: :ok

  def some_function([first | rest]) do
    some_function(rest)
  end
  ```

- <a name="multiple-function-defs"></a> Если у вас больше одного многострочного выражения `def`, не используйте однострочные `def`. <sup>[[ссылка](#multiple-function-defs)]</sup>

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

- <a name="pipe-operator"></a> Используйте оператор конвейера |> для объединения функций в цепочку. <sup>[[ссылка](#pipe-operator)]</sup>

  ```elixir
  # нежелательно
  String.trim(String.downcase(some_string))

  # предпочтительно
  some_string |> String.downcase() |> String.trim()

  # Многострочные конвейеры (pipelines) не требуют дополнительного отступа.
  some_string
  |> String.downcase()
  |> String.trim()

  # Многострочные конвейеры (pipelines) на правой стороне сопоставления с образцом
  # следует выравнивать по отступу на новой строке с правой частью выражения сопоставления.
  sanitized_string =
    some_string
    |> String.downcase()
    |> String.trim()
  ```

Хотя это предпочтительный метод, следует учитывать, что при копировании и вставке многострочных конвейеров в IEx может возникнуть синтаксическая ошибка, так как IEx будет оценивать первую строку, не
осознавая, что следующая строка содержит конвейер. Чтобы избежать этого, можно обернуть вставленный код в скобки.

- <a name="avoid-single-pipelines"></a> Избегайте использования оператора pipe |> только однократно. <sup>[[ссылка](#avoid-single-pipelines)]</sup>

  ```elixir
  # нежелательно
  some_string |> String.downcase()

  System.version() |> Version.parse()

  # предпочтительно
  String.downcase(some_string)

  Version.parse(System.version())
  ```

- <a name="bare-variables"></a> Используйте _простые_ (а не вызовы функций) переменные в начале цепочки функций. <sup>[[ссылка](#bare-variables)]</sup>

  ```elixir
  # нежелательно
  String.trim(some_string) |> String.downcase() |> String.codepoints()

  # предпочтительно
  some_string |> String.trim() |> String.downcase() |> String.codepoints()
  ```

- <a name="fun-def-parentheses"></a> Используйте скобки при объявлении `def`, если у функции есть аргументы, и не используйте скобки, если аргументов нет. <sup>[[ссылка](#fun-def-parentheses)]</sup>

  ```elixir
  # нежелательно
  def some_function arg1, arg2 do
    # body omitted
  end

  def some_function() do
    # body omitted
  end

  # предпочтительно
  def some_function(arg1, arg2) do
    # body omitted
  end

  def some_function do
    # body omitted
  end
  ```

- <a name="do-with-single-line-if-unless"></a> Используйте `do:`: для однострочных операторов `if/unless`. <sup>[[ссылка](#do-with-single-line-if-unless)]</sup>

  ```elixir
  # предпочтительно
  if some_condition, do: # some_stuff
  ```

- <a name="unless-with-else"></a> Никогда не используйте `unless` с `else`. Перепишите такие случаи в "положительном" виде с использованием `if`. <sup>[[ссылка](#unless-with-else)]</sup>

  ```elixir
  # нежелательно
  unless success do
    IO.puts('failure')
  else
    IO.puts('success')
  end

  # предпочтительно
  if success do
    IO.puts('success')
  else
    IO.puts('failure')
  end
  ```

- <a name="true-as-last-condition"></a> Используйте `true` в качестве последнего условия для специальной формы `cond`, когда вам нужна клауза, которая всегда срабатывает.
  <sup>[[ссылка](#true-as-last-condition)]</sup>

  ```elixir
  # нежелательно
  cond do
    1 + 2 == 5 ->
      "Nope"

    1 + 3 == 5 ->
      "Uh, uh"

    :else ->
      "OK"
  end

  # предпочтительно
  cond do
    1 + 2 == 5 ->
      "Nope"

    1 + 3 == 5 ->
      "Uh, uh"

    true ->
      "OK"
  end
  ```

- <a name="parentheses-and-functions-with-zero-arity"></a> Используйте скобки при вызове функций с нулевым арностью, чтобы они можно было отличить от переменных. Начиная с версии Elixir 1.4,
  компилятор будет предупреждать вас о местах, где существует неоднозначность. <sup>[[ссылка](#parentheses-and-functions-with-zero-arity)]</sup>

  ```elixir
  defp do_stuff, do: ...

  # нежелательно
  def my_func do
    # is this a variable or a function call?
    do_stuff
  end

  # предпочтительно
  def my_func do
    # this is clearly a function call
    do_stuff()
  end
  ```

### Именование

Это руководство следует [соглашениям об именовании][Naming Conventions] из документации Elixir, включая использование `snake_case` и `CamelCase` для описания правил написания имен.

- <a name="snake-case"></a> Используйте `snake_case` для атомов, функций и переменных. <sup>[[ссылка](#snake-case)]</sup>

  ```elixir
  # нежелательно
  :"some atom"
  :SomeAtom
  :someAtom

  someVar = 5

  def someFunction do
    ...
  end

  # предпочтительно
  :some_atom

  some_var = 5

  def some_function do
    ...
  end
  ```

- <a name="camel-case"></a> Используйте `CamelCase` для модулей (оставляйте аббревиатуры, такие как HTTP, RFC, XML, в верхнем регистре).<sup>[[ссылка](#camel-case)]</sup>

  ```elixir
  # нежелательно
  defmodule Somemodule do
    ...
  end

  defmodule Some_Module do
    ...
  end

  defmodule SomeXml do
    ...
  end

  # предпочтительно
  defmodule SomeModule do
    ...
  end

  defmodule SomeXML do
    ...
  end
  ```

- <a name="predicate-function-trailing-question-mark"></a> Функции, которые возвращают булевое значение (`true` или `false`), должны иметь название с вопросительным знаком в конце.
  <sup>[[ссылка](#predicate-function-trailing-question-mark)]</sup>

  ```elixir
  def cool?(var) do
    String.contains?(var, "cool")
  end
  ```

- <a name="predicate-function-is-prefix"></a> Логические проверки, которые можно использовать в ограничителях (guard clauses), должны иметь префикс `is_`. Для списка разрешенных выражений см.
  [Ограничители][Guard Expressions] в документации. <sup>[[ссылка](#predicate-function-is-prefix)]</sup>

  ```elixir
  defguard is_cool(var) when var == "cool"
  defguard is_very_cool(var) when var == "very cool"
  ```

- <a name="private-functions-with-same-name-as-public"></a> Не следует давать приватным функциям то же имя, что и у публичных функций. Кроме того, не рекомендуется использовать шаблон `def name` и
  `defp do_name`.

Обычно можно попытаться найти более описательные имена, сосредоточившись на различиях. <sup>[[ссылка](#private-functions-with-same-name-as-public)]</sup>

```elixir
def sum(list), do: sum_total(list, 0)

# приватные функции
defp sum_total([], total), do: total
defp sum_total([head | tail], total), do: sum_total(tail, head + total)
```

### Комментарии

- <a name="expressive-code"></a> Пишите выразительный код и старайтесь передать намерения вашей программы через управляющие конструкции, структуру и названия. <sup>[[ссылка](#expressive-code)]</sup>

- <a name="comment-grammar"></a> Комментарии длиннее одного слова должны начинаться с заглавной буквы, а предложения в них должны иметь знаки препинания. Используйте [один пробел][Sentence Spacing]
  после точек. <sup>[[ссылка](#comment-grammar)]</sup>

  ```elixir
  # нежелательно
  # этот комментарий начинается с маленькой буквы и не содержат знаков препинания

  # предпочтительно
  # Начинайте комментарий с заглавной буквы, используйте знаки препинания.
  ```

- <a name="comment-line-length"></a> Ограничьте длину комментариев до 100 символов. <sup>[[ссылка](#comment-line-length)]</sup>

#### Комментарии-аннотации

- <a name="annotations"></a> Аннотации обычно должны быть написаны на строке непосредственно над соответствующим кодом. <sup>[[ссылка](#annotations)]</sup>

- <a name="annotation-keyword"></a> Ключевое слово аннотации пишется с заглавной буквы, за которым следует двоеточие и пробел, а затем примечание, описывающее проблему.
  <sup>[[ссылка](#annotation-keyword)]</sup>

  ```elixir
  # TODO: Deprecate in v1.5.
  def some_function(arg), do: {:ok, arg}
  ```

- <a name="exceptions-to-annotations"></a> В случаях, когда проблема настолько очевидна, что любая документация будет избыточной, аннотации могут оставаться без примечания. Однако это должно быть
  исключением, а не правилом. <sup>[[ссылка](#exceptions-to-annotations)]</sup>

  ```elixir
  start_task()

  # FIXME
  Process.sleep(5000)
  ```

- <a name="todo-notes"></a> Используйте `TODO`, чтобы отметить отсутствующие функции или функциональность, которые должны быть добавлены в будущем. <sup>[[ссылка](#todo-notes)]</sup>

- <a name="fixme-notes"></a> Используйте `FIXME` для отметки о неисправном коде, который нуждается в исправлении. <sup>[[ссылка](#fixme-notes)]</sup>

- <a name="optimize-notes"></a> Используйте `OPTIMIZE`, чтобы отметить медленный или неэффективный код, который может вызвать проблемы с производительностью. <sup>[[ссылка](#optimize-notes)]</sup>

- <a name="hack-notes"></a> Используйте `HACK`, чтобы указать на "запахи кода", где были использованы сомнительные методы написания кода и их следует переработать. <sup>[[ссылка](#hack-notes)]</sup>

- <a name="review-notes"></a> Используйте `REVIEW`, чтобы отметить все, что должно быть рассмотрено, чтобы убедиться, что оно работает по назначению. Например:
  `REVIEW: Мы уверены, что это то, как клиент сейчас делает X?` <sup>[[ссылка](#review-notes)]</sup>

- <a name="custom-keywords"></a> Используйте другие пользовательские ключевые слова аннотации, если они кажутся уместными, но не забудьте задокументировать их в файле `README` вашего проекта или
  аналогичном файле. <sup>[[ссылка](#custom-keywords)]</sup>

### Модули

- <a name="one-module-per-file"></a> Задавайте один модуль на файл, если только модуль не используется только внутри другого модуля (например, внутри теста).
  <sup>[[ссылка](#one-module-per-file)]</sup>

- <a name="underscored-filenames"></a> Задавайте имена файлов в `snake_case` для имен модулей в `CamelCase`. <sup>[[ссылка](#underscored-filenames)]</sup>

  ```elixir
  # Файл называется some_module.ex.

  defmodule SomeModule do
  end
  ```

- <a name="module-name-nesting"></a> Каждый уровень вложенности в имени модуля должен быть представлен в виде отдельной директории. <sup>[[ссылка](#module-name-nesting)]</sup>

  ```elixir
  # file is called parser/core/xml_parser.ex

  defmodule Parser.Core.XMLParser do
  end
  ```

- <a name="module-attribute-ordering"></a> Список [атрибутов модуля][Module Attributes], директив и макросов должен быть упорядочен следующим образом: <sup>[[ссылка](#module-attribute-ordering)]</sup>

  1. `@moduledoc`
  1. `@behaviour`
  1. `use`
  1. `import`
  1. `require`
  1. `alias`
  1. `@module_attribute`
  1. `defstruct`
  1. `@type`
  1. `@callback`
  1. `@macrocallback`
  1. `@optional_callbacks`
  1. `defmacro`, `defmodule`, `defguard`, `def`, и т.д.

  Добавляйте пустую строку между каждой группой и сортируйте термины (такие как имена модулей) в алфавитном порядке. Вот общий пример того, как должны быть упорядочены элементы в ваших модулях:

```elixir
defmodule MyModule do
  @moduledoc """
  Пример модуля
  """

  @behaviour MyBehaviour

  use GenServer

  import Something
  import SomethingElse

  require Integer

  alias My.Long.Module.Name
  alias My.Other.Module.Example

  @module_attribute :foo
  @other_attribute 100

  defstruct [:name, params: []]

  @type params :: [{binary, binary}]

  @callback some_function(term) :: :ok | {:error, term}

  @macrocallback macro_name(term) :: Macro.t()

  @optional_callbacks macro_name: 1

  @doc false
  defmacro __using__(_opts), do: :no_op

  @doc """
  Определяет, когда терм равен :ok. Разрешено использование в ограничениях (guards).
  """
  defguard is_ok(term) when term == :ok

  @impl true
  def init(state), do: {:ok, state}

  # Определите другие функции здесь.
end
```

- <a name="module-pseudo-variable"></a> Используйте псевдопеременную `__MODULE__`, когда модуль ссылается на самого себя. Это позволяет избежать необходимости обновлять ссылки на себя при изменении
  имени модуля. <sup>[[ссылка](#module-pseudo-variable)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    defstruct [:name]

    def name(%__MODULE__{name: name}), do: name
  end
  ```

- <a name="alias-self-referencing-modules"></a> Если вам нужно более удобное имя для ссылки на сам модуль, можно настроить псевдоним (alias). <sup>[[ссылка](#alias-self-referencing-modules)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    alias __MODULE__, as: SomeModule

    defstruct [:name]

    def name(%SomeModule{name: name}), do: name
  end
  ```

- <a name="repetitive-module-names"></a> Избегайте повторения фрагментов в названиях модулей и пространств имен. Это повышает общую читаемость и устраняет [неоднозначность
  псевдонимов][Conflicting Aliases]. <sup>[[ссылка](#repetitive-module-names)]</sup>

  ```elixir
  # нежелательно
  defmodule Todo.Todo do
    ...
  end

  # предпочтительно
  defmodule Todo.Item do
    ...
  end
  ```

### Документация

Документация в Elixir (когда оно либо читается в `iex` с помощью `h`, либо генерируется с помощью [ExDoc]), использует атрибуты модуля `@moduledoc` и `@doc`.

- <a name="moduledocs"></a> Всегда используйте атрибут `@moduledoc` в строке сразу после `defmodule` в вашем модуле. <sup>[[ссылка](#moduledocs)]</sup>

  ```elixir
  # нежелательно

  defmodule AnotherModule do
    use SomeModule

    @moduledoc """
    О модуле
    """
    ...
  end

  # предпочтительно

  defmodule AThirdModule do
    @moduledoc """
    О модуле
    """

    use SomeModule
    ...
  end
  ```

- <a name="moduledoc-false"></a> Используйте `@moduledoc false`, если не планируете документировать модуль. <sup>[[ссылка](#moduledoc-false)]</sup>

  ```elixir
  defmodule SomeModule do
    @moduledoc false
    ...
  end
  ```

- <a name="moduledoc-spacing"></a> Отделяйте код после `@moduledoc` пустой строкой. <sup>[[ссылка](#moduledoc-spacing)]</sup>

  ```elixir
  # нежелательно
  defmodule SomeModule do
    @moduledoc """
    О модуле
    """
    use AnotherModule
  end

  # предпочтительно
  defmodule SomeModule do
    @moduledoc """
    О модуле
    """

    use AnotherModule
  end
  ```

- <a name="heredocs"></a> Для документирования используйте `heredoc-синтаксис` (код "как есть") с разметкой `markdown`. <sup>[[ссылка](#heredocs)]</sup>

```elixir
# нежелательно
defmodule SomeModule do
  @moduledoc "О модуле"
end

defmodule SomeModule do
  @moduledoc """
  О модуле

  Examples:
  iex> SomeModule.some_function
  :result
  """
end

# предпочтительно
defmodule SomeModule do
  @moduledoc """
  О модуле

  ## Examples

      iex> SomeModule.some_function
      :result
  """
end
```

### Аннотации типов

Аннотации типов - это нотация для объявления типов и спецификаций, используемая для документирования или для использования инструмента статического анализа Dialyzer.

Пользовательские типы должны быть определены вверху модуля вместе с другими директивами (см. [Модули](#modules)).

- <a name="typedocs"></a>Располагайте определения @typedoc и @type вместе, а каждую пару разделяйте пустой строкой. <sup>[[ссылка](#typedocs)]</sup>

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

- <a name="union-types"></a> Для длинных объединённых типов (union type), которые не умещаются на одной строке, следует помещать каждую часть типа на отдельной строке с отступом на один уровень больше
  имени типа. <sup>[[ссылка](#union-types)]</sup>

  ```elixir
  # нежелательно
  @type long_union_type ::
          some_type | another_type | some_other_type | one_more_type | a_final_type

  # предпочтительно
  @type long_union_type ::
          some_type
          | another_type
          | some_other_type
          | one_more_type
          | a_final_type
  ```

- <a name="naming-main-types"></a> Назовите основной тип модуля `t`, например типовую спецификацию структуры (struct). <sup>[[ссылка](#naming-main-types)]</sup>

  ```elixir
  defstruct [:name, params: []]

  @type t :: %__MODULE__{
          name: String.t() | nil,
          params: Keyword.t()
        }
  ```

- <a name="spec-spacing"></a> Типы и спецификации следует размещать перед определением функции, после `@doc`, без разделения их пустой строкой. <sup>[[ссылка](#spec-spacing)]</sup>

  ```elixir
  @doc """
  Описание функции.
  """
  @spec some_function(term) :: result
  def some_function(some_data) do
    {:ok, some_data}
  end
  ```

### Structs

- <a name="nil-struct-field-defaults"></a> Используйте список атомов для того, чтобы задать поля структур со значением по умолчанию `nil`, а поля с другими значениями указывайте после.
  <sup>[[ссылка](#nil-struct-field-defaults)]</sup>

  ```elixir
  # нежелательно
  defstruct name: nil, params: nil, active: true

  # предпочтительно
  defstruct [:name, :params, active: true]
  ```

- <a name="struct-def-brackets"></a> Опускайте квадратные скобки, когда аргументом `defstruct` является ключевой список. <sup>[[ссылка](#struct-def-brackets)]</sup>

  ```elixir
  # нежелательно
  defstruct [params: [], active: true]

  # предпочтительно
  defstruct params: [], active: true

  # required - brackets are not optional, with at least one atom in the list
  defstruct [:name, params: [], active: true]
  ```

- <a name="multiline-structs"></a>Если определение структуры занимает несколько строк, разместите каждый элемент на своей собственной строке, сохраняя выравнивание элементов.
  <sup>[[ссылка](#multiline-structs)]</sup>

```elixir
defstruct foo: "test",
          bar: true,
          baz: false,
          qux: false,
          quux: 1
```

Если многострочное определение структуры требует скобок, отформатируйте его как многострочный список:

```elixir
defstruct [
  :name,
  params: [],
  active: true
]
```

### Исключения

- <a name="exception-names"></a> Названия исключений должны заканчиваться на `Error`. <sup>[[ссылка](#exception-names)]</sup>

  ```elixir
  # нежелательно
  defmodule BadHTTPCode do
    defexception [:message]
  end

  defmodule BadHTTPCodeException do
    defexception [:message]
  end

  # предпочтительно
  defmodule BadHTTPCodeError do
    defexception [:message]
  end
  ```

- <a name="lowercase-error-messages"></a> Используйте строчные буквы в сообщениях об ошибках, когда вызываете исключения, и не используйте знаки
  препинания.<sup>[[ссылка](#lowercase-error-messages)]</sup>

  ```elixir
  # нежелательно
  raise ArgumentError, "This is not valid."

  # предпочтительно
  raise ArgumentError, "this is not valid"
  ```

### Коллекции

- <a name="keyword-list-syntax"></a> Всегда используйте специальный синтаксис для ключевых списков. <sup>[[ссылка](#keyword-list-syntax)]</sup>

  ```elixir
  # нежелательно
  some_value = [{:a, "baz"}, {:b, "qux"}]

  # предпочтительно
  some_value = [a: "baz", b: "qux"]
  ```

- <a name="map-key-atom"></a> Используйте сокращенный синтаксис "ключ: значение" для ассоциативных массивов, когда все ключи являются атомами. <sup>[[ссылка](#map-key-atom)]</sup>

  ```elixir
  # нежелательно
  %{:a => 1, :b => 2, :c => 0}

  # предпочтительно
  %{a: 1, b: 2, c: 3}
  ```

- <a name="map-key-arrow"></a> Используйте для ассоциативных массивов подробный синтаксис "ключ => значение", если хотя бы один ключ не является атомом. <sup>[[ссылка](#map-key-arrow)]</sup>

  ```elixir
  # нежелательно
  %{"c" => 0, a: 1, b: 2}

  # предпочтительно
  %{:a => 1, :b => 2, "c" => 0}
  ```

### Строки

- <a name="strings-matching-with-concatenator"></a> Сопоставляйте строки, используя оператор конкантенации строк (<>), а не бинарные шаблоны: <sup>[[ссылка](#strings-matching-with-concatenator)]</sup>

  ```elixir
  # нежелательно
  <<"my"::utf8, _rest::bytes>> = "my string"

  # предпочтительно
  "my" <> _rest = "my string"
  ```

### Регулярные выражения

_Никаких рекомендаций для регулярных выражений пока не добавлено._

### Метапрограммирование

- <a name="avoid-metaprogramming"></a> Избегайте ненужного метапрограммирования. <sup>[[ссылка](#avoid-metaprogramming)]</sup>

### Тестирование

- <a name="testing-assert-order"></a> При написании утверждений [ExUnit] помещайте проверяемое выражение слева от оператора, а ожидаемый результат - справа, если только утверждение не является
  сопоставлением с образцом. <sup>[[ссылка](#testing-assert-order)]</sup>

  ```elixir
  # предпочтительно
  assert actual_function(1) == true

  # нежелательно
  assert true == actual_function(1)

  # необходимо, т.к. утверждение является сопоставлением с образцом
  assert {:ok, expected} = actual_function(3)
  ```

## Ресурсы

### Альтернативные руководства по стилю

- [Руководство по стилю Elixir от Алексея Магусева](https://github.com/lexmag/elixir-style-guide#readme) — Руководство по стилю Elixir, основанное на стиле кодирования, принятом в библиотеках ядра
  Elixir. Разработано [Алексеем Магусевым](https://github.com/lexmag) и [Андреа Леопарди](https://github.com/whatyouhide), членами основной команды Elixir. Хотя проект Elixir не придерживается
  какого-либо конкретного руководства по стилю, это наиболее приближенное к его конвенциям руководство.

- [Credo's Elixir Style Guide](https://github.com/rrrene/elixir-style-guide#readme) - Руководство по стилю для языка Elixir, реализованное с помощью инструмента статического анализа кода
  [Credo](http://credo-ci.org).

### Инструменты

Обратитесь к разделу [Awesome Elixir][Code Analysis] за библиотеками и инструментами, которые могут помочь с анализом кода и линтингом стилей.

## Участие

### Вклад

Мы надеемся, что это станет центральным узлом для обсуждения сообществом лучших практик Elixir. Не стесняйтесь открывать тикеты или отправлять пулл-реквесты. Заранее спасибо за вашу помощь!

Для получения дополнительной информации ознакомьтесь с [руководством по участию в проекте][Contributing].

### Распространение

Руководство по стилю сообщества бессмысленно без поддержки сообщества. Пожалуйста, напишите в твиттере, [star][Stargazers], и сообщите программистам Elixir об [этом руководстве][Elixir Style Guide],
чтобы они могли внести свой вклад.

## Копирование

### Лицензия

![Creative Commons License](http://i.creativecommons.org/l/by/3.0/88x31.png) This work is licensed under a [Creative Commons Attribution 3.0 Unported License][License]

### Авторство

Структура этого руководства, фрагменты кода примеров и многие исходные положения, изложенные в этом документе, были заимствованы из [руководства по стилю сообщества Ruby][Ruby community style guide].
Многие вещи применимы к Elixir, что позволило нам быстрее выпустить этот документ, чтобы начать дискуссию.

Вот [список людей, которые внесли любезный вклад][Contributors] в этот проект.

<!-- ссылкаs -->

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
[Naming Conventions]: https://hexdocs.pm/elixir/naming-conventions.html
[Portuguese]: https://github.com/gusaiani/elixir_style_guide/blob/master/README_ptBR.md
[Ruby community style guide]: https://github.com/bbatsov/ruby-style-guide
[Sentence Spacing]: http://en.wikipedia.org/wiki/Sentence_spacing
[Spanish]: https://github.com/iver/elixir_style_guide/blob/spanish/i18n/README_es.md
[Stargazers]: https://github.com/christopheradams/elixir_style_guide/stargazers
