# [Guía de estilo de Elixir][Elixir Style Guide]

## Tabla de Contenidos

* __[Preludio](#preludio)__
* __[Acerca de](#about)__
  * [Traducciones](#translations)
* __[Formato](#formato)__
  * [Espacio en blanco](#whitespace)
  * [Indentation](#indentation)
  * [Parentheses](#parentheses)
  * [Sintaxis](#sintaxis)
* __[The Guide](#the-guide)__
  * [Expressions](#expressions)
  * [Nombrado](#nombrado)
  * [Comentarios](#comentarios)
    * [Comentarios de Anotación](#comments-annotations)
  * [Módulos](#modules)
  * [Documentación](#documentation)
  * [Typespecs](#typespecs)
  * [Structs](#structs)
  * [Excepciones](#excepciones)
  * [Colecciones](#collections)
  * [Strings](#strings)
  * _Expresiones Regulares_
  * [Metaprogramming](#metaprogramming)
  * [Testing](#testing)
* __[Resources](#resources)__
  * [Guías de Estilo Alternativas](#alternative-style-guides)
  * [Herramientas](#tools)
* __[Cómo participar](#getting-involved)__
  * [Contribuir](#contribuir)
  * [Corre la voz](#corre-la-voz)
* __[Derechos](#derechos)__
  * [Licencia](#licencia)
  * [Atribución](#attribution)

## Preludio

> Arquitectura líquida. Es como el jazz — improvisar, trabajar juntos, tocar
> los unos con los otros, haces algo, hacen algo.
>
> —Frank Gehry

El estilo importa. Aunque [Elixir] tiene mucho estilo, como ocurre con todos los
lenguajes, puede estropearse. **No estropees el estilo.**

## <a name="about">Acerca de</a>

Esta es la guía de estilo de la comunidad para
[el lenguaje de programación Elixir][Elixir]. Por favor, siéntete libre de abrir
pull requests y sugerencias, y ¡forma parte de la vibrante comunidad de Elixir!

Si estás buscando otros proyectos en los que contribuir, por favor ve al
[sitio web de Hex package manager][Hex].

### <a name="translations">Traducciones</a>

Las traducciones de la guía están disponibles en los siguientes lenguajes:

* [Chino Simplificado]
* [Chino Tradicional]
* [Frances]
* [Japones]
* [Coreano]
* [Portugues]
* [Español]
* [Ingles]


## Formato

Elixir v1.6 introduce el __formateador de código__ ( [Code Formatter] ) y la tarea de [mix format].
Se debe preferir el formateador para todos los proyectos nuevos y el código fuente.

El formateador de código aplica automáticamente las reglas de esta sección,
pero se proporcionan aquí como ejemplos del estilo preferido.

### <a name="whitespace">Espacio en blanco</a>

* <a name="trailing-whitespace"></a>
  Evitar los espacios en blanco al final de línea.
  <sup>[[enlace](#trailing-whitespace)]</sup>

* <a name="newline-eof"></a>
  Terminar cada archivo con una nueva línea.
  <sup>[[enlace](#newline-eof)]</sup>

* <a name="line-endings"></a>
  Usar los finales de línea de Unix (Los usuarios de \*BSD/Solaris/Linux/OSX ya están
  cubiertos por defecto, pero los usuarios de Windows tendrán que prestar especial
  atención).
  <sup>[[enlace](#line-endings)]</sup>

* <a name="autocrlf"></a>
  Al usar Git puede que quieras utilizar la siguiente configuración para protegerte
  de que se cuelen los finales de línea en Windows:
  <sup>[[enlace](#autocrlf)]</sup>

  ```sh
  git config --global core.autocrlf true
  ```
  
* <a name="line-length"></a>
  Limitar las líneas a 98 caracteres.
  De lo contrario, asignar la opción de `:line_length` en el archivo `.formatter.exs`.
  <sup>[[enlace](#line-length)]</sup>

* <a name="spaces"></a>
  Usar espacios alrededor de operadores, después de comas, dos puntos y punto y coma.
  No colocar espacios alrededor de parejas como llaves, paréntesis, etc.
  Los espacios en blanco puede que sean (en la mayoría de casos) irrelevantes para
  Elixir en tiempo de ejecución, pero su uso apropiado es clave para escribir código
  fácilmente legible. <sup>[[enlace](#spaces)]</sup>

  ```elixir
  sum = 1 + 2
  {a, b} = {2, 3}
  [first | rest] = [1, 2, 3]
  Enum.map(["one", <<"two">>, "three"], fn num -> IO.puts(num) end)
  ```

* <a name="no-spaces"></a>
  No usar espacios después de operadores que no sean una palabra y que sólo
  reciben un argumento; o alrededor del operador de rango.
  <sup>[[enlace](#no-spaces)]</sup>

  ```elixir
  0 - 1 == -1
  ^pinned = some_func()
  5 in 1..10
  ```

* <a name="def-spacing"></a>
  Utilizar líneas en blanco entre `def`s para separar las funciones en párrafos lógicos.
  <sup>[[enlace](#def-spacing)]</sup>

  ```elixir
  def some_function(some_data) do
    some_data 
	  |> other_function() 
	  |> List.first()
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
  No dejar líneas en blanco después de `defmodule`.
  <sup>[[link](#defmodule-spacing)]</sup>

* <a name="long-dos"></a>
  Si se utiliza la sintaxis `do:` con funciones y la línea que constituye el cuerpo
  de la función es demasiado larga, se debe poner el `do:` en una nueva línea con 
  un nivel de indentación más que la línea anterior.
  <sup>[[enlace](#long-dos)]</sup>

  ```elixir
  def some_function([:foo, :bar, :baz] = args),
    do: Enum.map(args, fn arg -> arg <> " is on a very long line!" end)
  ```

  Cuando la cláusula `do:` comienza en su propia línea, se trata como una función multilínea separándola con líneas en blanco.

  ```elixir
  # no recomendado
  def some_function([]), do: :empty
  def some_function(_),
    do: :very_long_line_here

  # recomendado
  def some_function([]), do: :empty
  
  def some_function(_),
    do: :very_long_line_here
  ```

* <a name="add-blank-line-after-multiline-assignment"></a>
  Agregar una línea en blanco tras una "asignación" multilínea como una pista
  visual de que ha terminado.
  <sup>[[enlace](#add-blank-line-after-multiline-assignment)]</sup>

  ```elixir
  # no recomendado
  some_string =
    "Hello"
    |> String.downcase()
    |> String.trim()
  another_string <> some_string

  # recomendado
  some_string =
    "Hello"
    |> String.downcase()
    |> String.trim()

  another_string <> some_string
  ```

  ```elixir
  # tampoco recomendado
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end
  String.downcase(something)

  # recomendado
  something =
    if x == 2 do
      "Hi"
    else
      "Bye"
    end

  String.downcase(something)
  ```

* <a name="multiline-enums"></a>
  Si una lista, mapa o estructura abarca varias líneas, colocar cada elemento, así como
   los corchetes de apertura y cierre, en su propia línea.
   Sangrar cada elemento un nivel, pero no los corchetes.  <sup>[[link](#multiline-enums)]</sup>

  ```elixir
  # no recomendado
  [:first_item, :second_item, :next_item,
  :final_item]

  # recomendado
  [
    :first_item,
    :second_item,
    :next_item,
    :final_item
  ]
  ```

* <a name="multiline-list-assign"></a>
  Al definir una lista que ocupa varias líneas, iniciar la lista en una nueva línea,
  e indentar los elementos para mantenerlos alineados.
  <sup>[[enlace](#multiline-list-assign)]</sup>

  ```elixir
  # no recomendado
  list = [:first_item, :second_item, :next_item,
  :last_item]

  # no recomendado
  list = [:first_item, :second_item, :next_item,
          :last_item]

  # no recomendado
  list =
  [
    :first_item,
    :second_item
  ]

  # recomendado
  list = [
    :first_item,
    :second_item
  ]
  ```

* <a name="multiline-case-clauses"></a>
  Cuando las cláusulas `case` o `cond` abarcan multiples líneas, separar cada una con una 
  línea en blanco.
  <sup>[[link](#multiline-case-clauses)]</sup>

  ```elixir
  # no recomendado
  case arg do
    true ->
      :ok
    false ->
      :error
  end

  # recomendado
  case arg do
    true ->
      :ok

    false ->
      :error
  end
  ```

* <a name="comments-above-line"></a>
  Colocar los comentarios sobre la línea que se comenta.  
  <sup>[[link](#comments-above-line)]</sup>

  ```elixir
  String.first(some_string) # no recomendado

  # recomendado
  String.first(some_string)
  ```

* <a name="comment-leading-spaces"></a>
  Utilizar un espacio entre el carácter introductorio del comentario `#` y el
  resto del texto del comentario.
  <sup>[[enlace](#comment-leading-spaces)]</sup>

  ```elixir
  #no recomendado
  String.first(some_string)

  # recomendado
  String.first(some_string)
  ```

### Sangría o Identación

* <a name="with-clauses"></a>
  Indentar y alinear las cláusulas `with` sucesivas.
  Poner el argumento `do:` en una nueva línea, indentada normalmente.
  <sup>[[enlace](#with-clauses)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, my_var} <- fetch(opts, :my_var),
       do: {:ok, foo, my_var}
  ```

* <a name="with-else"></a>
  Si la expresión `with` tiene un bloque `do` con más de una línea, o tiene una opción
  `else`, utiliza la sintaxis multilínea.
  <sup>[[enlace](#with-else)]</sup>

  ```elixir
  with {:ok, foo} <- fetch(opts, :foo),
       {:ok, my_var} <- fetch(opts, :my_var) do
    {:ok, foo, my_var}
  else
    :error ->
      {:error, :bad_arg}
  end
  ```

### Paréntesis

* <a name="parentheses-pipe-operator"></a>
  Usar paréntesis para las funciones de aridad uno `function/1` cuando se usa el operador de tubería (pipe) (`|>`).
  <sup>[[link](#parentheses-pipe-operator)]</sup>

  ```elixir
  # no recomendado
  some_string |> String.downcase |> String.trim

  # recomendado
  some_string |> String.downcase() |> String.trim()
  ```

* <a name="function-names-with-parentheses"></a>
  Nunca dejar un espacio entre el nombre de la función y el paréntesis de apertura.
  <sup>[[enlace](#function-names-with-parentheses)]</sup>

  ```elixir
  # no recomendado
  f (3 + 2)

  # recomendado
  f(3 + 2)
  ```

* <a name="function-calls-and-parentheses"></a>
  Utilizar paréntesis en las llamadas a funciones, sobretodo dentro de un pipeline.
  <sup>[[enlace](#function-calls-and-parentheses)]</sup>

  ```elixir
  # no recomendado
  f 3

  # recomendado
  f(3)

  # no recomendado y además se interpreta como rem(2, (3 |> g)),
  # que no es lo que se quiere.
  2 |> rem 3 |> g

  # recomendado
  2 |> rem(3) |> g
  ```

* <a name="keyword-list-brackets"></a>
  Omitir los corchetes de las listas de keywords siempre que sean opcionales.
  <sup>[[enlace](#keyword-list-brackets)]</sup>

  ```elixir
  # no recomendado
  some_function(foo, bar, [a: "baz", b: "qux"])

  # recomendado
  some_function(foo, bar, a: "baz", b: "qux")
  ```

## La Guía

El formateador de código no puede aplicar las reglas de esta sección, pero son
una práctica generalmente preferida.

### Expresiones

* <a name="single-line-defs"></a>
  Agrupar `def`s de una sola línea que coincidan en nombre de función y respuesta, 
  pero separar los `def`s multilinea o no coincidentes con una línea en blanco.
  <sup>[[link](#single-line-defs)]</sup>

  ```elixir
  def some_function(nil), do: {:error, "No Value"}
  def some_function([]), do: :ok

  def some_function([first | rest]) do
    some_function(rest)
  end
  ```

* <a name="multiple-function-defs"></a>
  Si se tiene más de un `def`s multilínea, no usar `def`s de una sola línea.
  <sup>[[enlace](#multiple-function-defs)]</sup>

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
  Usar el operador pipe (`|>`) para encadenar funciones una tras otra.
  <sup>[[enlace](#pipe-operator)]</sup>

  ```elixir
  # no recomendado
  String.trim(String.downcase(some_string))

  # recomendado
  some_string |> String.downcase() |> String.trim()

  # Los pipelines multilínea no se indentan a mayores
  some_string
  |> String.downcase()
  |> String.trim()

  # Los pipelines multilínea que estén en el lado derecho de un pattern match
  # deben ser indentados en una nueva línea
  sanitized_string =
    some_string
    |> String.downcase()
    |> String.trim()
  ```

  Aunque este sea el método recomendado, se debe tener en cuenta que al copiar y pegar
  pipelines multilínea en IEx podría causar un error de sintaxis, ya que IEx
  evaluará la primera línea sin darse cuenta de que la siguiente línea tiene
  otro pipeline.

* <a name="avoid-single-pipelines"></a>
  Evitar utilizar el operador pipe una única vez.
  <sup>[[enlace](#avoid-single-pipelines)]</sup>

  ```elixir
  # no recomendado
  some_string |> String.downcase()

  # recomendado
  String.downcase(some_string)
  ```

* <a name="bare-variables"></a>
  Utilizar variables simples (_bare_ variables) como comienzo de una cadena de funciones.
  <sup>[[enlace](#bare-variables)]</sup>

  ```elixir
  # ¡NUNCA HACER ESTO!
  # Realmente se interpretará como String.trim("nope" |> String.downcase).
  String.trim "nope" |> String.downcase

  # no recomendado
  String.trim(some_string) |> String.downcase() |> String.codepoints()

  # recomendado
  some_string |> String.trim() |> String.downcase() |> String.codepoints()
  ```



### Sintaxis

* <a name="fun-def-parentheses"></a>
  Usar paréntesis cuando `def` tenga argumentos, y omitir cuando no.
  <sup>[[enlace](#fun-def-parentheses)]</sup>

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

* <a name="do-with-single-line-if-unless"></a>
  Utilizar `do:` para sentencias `if/unless` de una sola línea.
  <sup>[[enlace](#do-with-single-line-if-unless)]</sup>

  ```elixir
  # recomendado
  if some_condition, do: # some_stuff
  ```

* <a name="unless-with-else"></a>
  Nunca utilizar `unless` con `else`.
  Reescribir poniendo el caso positivo primero.
  <sup>[[enlace](#unless-with-else)]</sup>

  ```elixir
  # no recomendado
  unless success do
    IO.puts('failure')
  else
    IO.puts('success')
  end

  # recomendado
  if success do
    IO.puts('success')
  else
    IO.puts('failure')
  end
  ```

* <a name="true-as-last-condition"></a>
  Utilizar `true` como la última condición de `cond` cuando necesites una
  cláusula por defecto.
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

* <a name="parentheses-and-functions-with-zero-arity"></a>
  Usar paréntesis para llamadas a funciones con aridad cero, de tal forma que puedan
  ser distinguidas de las variables.
  A partir de Elixir 1.4, el compilador avisará de los lugares en los que exista
  ambigüedad.
  <sup>[[enlace](#parentheses-and-functions-with-zero-arity)]</sup>

  ```elixir
  defp do_stuff, do: ...

  # no recomendado
  def my_func do
	# ¿es una variable o una llamada a una función?
    do_stuff 
  end

  # recomendado
  def my_func do
	# esto es claramente una llamada a una función
    do_stuff()
  end
  ```

### Nombrado

* <a name="snake-case"></a>
  Usa `snake_case` para atoms, funciones y variables.
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

  # recomendado
  :some_atom

  some_var = 5

  def some_function do
    ...
  end
  ```

* <a name="camel-case"></a>
  Usar `CamelCase` para módulos (mantener los acrónimos como HTTP, RFC, XML en mayúsculas).
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
  Los nombres de macros predicado (funciones generadas en tiempo de compilación que
  devuelven un valor booleano) _que pueden ser utilizadas dentro de guards_ deberían
  prefijarse con `is_`. Para una lista de las expresiones permitidas, ver la documentación de [Guard][Guard Expressions].
  <sup>[[enlace](#predicate-macro-names-with-guards)]</sup>

  ```elixir
  defguard is_cool(var) when var == "cool"
  defguardp is_very_cool(var) when var == "very cool"
  ```

* <a name="predicate-macro-names-no-guards"></a>
  Los nombres de las funciones predicado _que no pueden ser usadas dentro de guards_
  deberían de terminar en signo de interrogación (`?`) en lugar de tener un prefijo
  `is_` (o similar).
  <sup>[[enlace](#predicate-macro-names-no-guards)]</sup>

  ```elixir
  def cool?(var) do
    # Complex check if var is cool not possible in a pure function.
  end
  ```

* <a name="private-functions-with-same-name-as-public"></a>
  Las funciones privadas que compartan el mismo nombre con alguna función pública
  deben empezar con `do_`.
  <sup>[[enlace](#private-functions-with-same-name-as-public)]</sup>

  ```elixir
  def sum(list), do: do_sum(list, 0)

  # private functions
  defp do_sum([], total), do: total
  defp do_sum([head | tail], total), do: do_sum(tail, head + total)
  ```

### Comentarios

* <a name="expressive-code"></a>
  Escribir código expresivo e intentar transmitir la intención del programa a
  través de flujos de control, estructura y nombrado.
  <sup>[[enlace](#expressive-code)]</sup>



* <a name="comment-grammar"></a>
  Los comentarios que sean más largos de una palabra se escribirán capitalizados,
  y las frases utilizarán signos de puntuación.
  Usa [un espacio][Sentence Spacing] tras cada punto.
  <sup>[[enlace](#comment-grammar)]</sup>

  ```elixir
  # no recomendado
  # a estos comentarios en minúsculas les falta los signos de puntuación

  # recomendado
  # Ejemplo de capitalización
  # Usa signos de puntuación para frases completas.
  ```

#### <a name="comments-annotations">Comentarios de Anotación</a>

* <a name="annotations"></a>
  Las anotaciones se escriben normalmente en la línea inmediatamente superior
  al código que anotan.
  <sup>[[enlace](#annotations)]</sup>

* <a name="annotation-keyword"></a>
  La palabra clave para la anotación estará completamente en mayúsculas,
  seguida de dos puntos y un espacio, a continuación se añade la nota que
  describe el problema.
  <sup>[[enlace](#annotation-keyword)]</sup>

  ```elixir
  # TODO: Deprecate in v1.5.
  def some_function(arg), do: {:ok, arg}
  ```

* <a name="exceptions-to-annotations"></a>
  En casos en los que el problema sea tan obvio que cualquier tipo de documentación
  resultará redundante, puedes poner las anotaciones al final de la línea sin
  ningún tipo de nota.
  Este uso debería de ser la excepción y no la norma.
  <sup>[[enlace](#exceptions-to-annotations)]</sup>

  ```elixir
  start_task()

  # FIXME
  Process.sleep(5000)
  ```

* <a name="todo-notes"></a>
  Usar `TODO` para anotar código que falte o funcionalidades que deberán ser añadidas
  posteriormente.
  <sup>[[enlace](#todo-notes)]</sup>

* <a name="fixme-notes"></a>
  Usar `FIXME` para denotar código que debe ser arreglado.
  <sup>[[enlace](#fixme-notes)]</sup>

* <a name="optimize-notes"></a>
  Usar `OPTIMIZE` para denotar código lento o ineficiente que pudiese llegar a
  causar problemas de rendimiento.
  <sup>[[enlace](#optimize-notes)]</sup>

* <a name="hack-notes"></a>
  Usar `HACK` para denotar "code smells" en los que se hayan empleado prácticas
  de programación cuestionables y que deban ser refactorizados.
  <sup>[[enlace](#hack-notes)]</sup>

* <a name="review-notes"></a>
  Usar `REVIEW` para denotar cualquier cosa que deba ser revisada para confirmar
  que funciona como se espera.
  Por ejemplo: `REVIEW: Are we sure this is how the client does X currently?`
  <sup>[[enlace](#review-notes)]</sup>

* <a name="custom-keywords"></a>
  Usar claves de anotación propias si lo consideras oportuno, pero asegúrate de
  documentarlas en el archivo `README` de tu proyecto o similar.
  <sup>[[enlace](#custom-keywords)]</sup>

### <a name="modules">Módulos</a>

* <a name="one-module-per-file"></a>
  Usar un archivo por módulo a no ser que el módulo sea utilizado únicamente de
  manera interna por otro módulo (como en el caso de un test).
  <sup>[[enlace](#one-module-per-file)]</sup>

* <a name="underscored-filenames"></a>
  Utilizar `snake_case` para el nombre del archivo y `CamelCase` para el nombre del
  módulo.
  <sup>[[enlace](#underscored-filenames)]</sup>

  ```elixir
  # el archivo es llamado some_module.ex

  defmodule SomeModule do
  end
  ```

* <a name="module-name-nesting"></a>
  Representar cada nivel de anidación dentro del módulo como un directorio.
  <sup>[[enlace](#module-name-nesting)]</sup>

  ```elixir
  # el archivo se llama parser/core/xml_parser.ex

  defmodule Parser.Core.XMLParser do
  end
  ```

* <a name="module-block-spacing"></a>
  Dejar una línea en blanco después de cada bloque de código a nivel de módulo.
  <sup>[[enlace](#module-block-spacing)]</sup>

* <a name="module-attribute-ordering"></a>
  Listar los atributos y directivas del módulo en el siguiente orden:
  <sup>[[enlace](#module-attribute-ordering)]</sup>

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

  Añadir una línea en blanco entre cada grupo, y ordenar alfabéticamente los términos
  (como nombres de módulo).
  Aquí un ejemplo general de cómo se debe ordenar el código en los módulos:

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
  Usar la pseudo variable `__MODULE__` cuando un módulo se refiera a sí mismo.
  Esto evitará actualizar cualquier referencia cuando el nombre
  del módulo cambie.
  <sup>[[enlace](#module-pseudo-variable)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    defstruct [:name]

    def name(%__MODULE__{name: name}), do: name
  end
  ```

* <a name="alias-self-referencing-modules"></a>
  Si se prefiere un nombre más bonito para esta referencia, se puede definir un alias.
  <sup>[[enlace](#alias-self-referencing-modules)]</sup>

  ```elixir
  defmodule SomeProject.SomeModule do
    alias __MODULE__, as: SomeModule

    defstruct [:name]

    def name(%SomeModule{name: name}), do: name
  end
  ```

* <a name="repetitive-module-names"></a>
  Evitar repeticiones en los nombres de módulos y espacios de nombrado.
  Esto mejora la legibilidad global y elimina [alias ambiguos][Conflicting Aliases].
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

### <a name="documentation"></a>Documentación

La documentación en Elixir (ya sea cuando es leída en `iex` mediante `h` o cuando
es generada con [ExDoc]) utiliza los [atributos de módulo][Module Attributes]
`@moduledoc` y `@doc`.

* <a name="moduledocs"></a>
  Incluir siempre un atributo `@moduledoc` en la línea inmediatamente posterior a
  `defmodule` de un módulo.
  <sup>[[enlace](#moduledocs)]</sup>

  ```elixir
  # no recomendado

  defmodule AnotherModule do
    use SomeModule

    @moduledoc """
    About the module
    """
    ...
  end

  # recomendado

  defmodule AThirdModule do
    @moduledoc """
    About the module
    """

    use SomeModule
    ...
  end
  ```

* <a name="moduledoc-false"></a>
  Utilizar `@moduledoc false` si no se desea documentar un módulo.
  <sup>[[enlace](#moduledoc-false)]</sup>

  ```elixir
  defmodule SomeModule do
    @moduledoc false
    ...
  end
  ```

* <a name="moduledoc-spacing"></a>
  Separa el código después de `@moduledoc` con una línea en blanco.
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
  Usar heredocs con markdown para la documentación.
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

Typespecs es una notación para declarar tipos y especificaciones, ya sea para
documentación o para la herramienta de análisis estático Dialyzer.

Los tipos propios deben de ser definidos en la parte superior del módulo junto
con las demás directivas (ver [Módulos](#modules)).

* <a name="typedocs"></a>
  Situar las definiciones `@typedoc` y `@type` juntas, y separar cada par con una
  línea en blanco.
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
  Si la unión de tipos es demasiado larga para caber en una sola línea, añadir
  una nueva línea e indentar con espacios para mantener los tipos alineados.
  <sup>[[enlace](#union-types)]</sup>

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
  Nombrar al tipo principal para un módulo `t`, por ejemplo: la especificación de
  tipo para una estructura (struct).
  <sup>[[enlace](#naming-main-types)]</sup>

  ```elixir
  defstruct [:name, params: []]

  @type t :: %__MODULE__{
          name: String.t() | nil,
          params: Keyword.t()
        }
  ```

* <a name="spec-spacing"></a>
  Situar las especificaciones justo antes de la definición de la función después de `@doc`,
  sin separarlas con una línea en blanco.
  <sup>[[enlace](#spec-spacing)]</sup>

  ```elixir
  @doc """
  Some function description.
  """
  @spec some_function(term) :: result
  def some_function(some_data) do
    {:ok, some_data}
  end
  ```

### <a name="structs"></a> Estructuras

* <a name="nil-struct-field-defaults"></a>
  Usar una lista de atoms para los campos de la struct que tengan valor `nil`, seguida
  del resto de claves.
  <sup>[[enlace](#nil-struct-field-defaults)]</sup>

  ```elixir
  # no recomendado
  defstruct name: nil, params: nil, active: true

  # recomendado
  defstruct [:name, :params, active: true]
  ```

* <a name="struct-def-brackets"></a>
  Omitir los corchetes cuando el argumento de `defstruct` sea una lista de keywords.
  <sup>[[enlace](#struct-def-brackets)]</sup>

  ```elixir
  # no recomendado
  defstruct [params: [], active: true]

  # recomendado
  defstruct params: [], active: true

  # obligatorio - los corchetes no son opcionales cuando la lista tenga al menos
  # un átomo
  defstruct [:name, params: [], active: true]
  ```

* <a name="multiline-structs"></a>
  Si la definición de una estructura abarca múltiples líneas, poner cada elemento en su propia línea,
  manteniendo los elementos alineados.
  <sup>[[link](#multiline-structs)]</sup>

  ```elixir
  defstruct foo: "test",
            bar: true,
            baz: false,
            qux: false,
            quux: 1
  ```

  Si una estructura con múltiples líneas requiere corchetes, formatear como una lista de múltiples líneas:

  ```elixir
  defstruct [
    :name,
    params: [],
    active: true
  ]
  ```

### <a name="exceptions"></a> Excepciones

* <a name="exception-names"></a>
  Hacer que los nombres de las excepciones terminen en `Error`.
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
  Usar mensajes de error en minúsculas cuando lances excepciones. No usar
  puntuación al final.
  <sup>[[enlace](#lowercase-error-messages)]</sup>

  ```elixir
  # no recomendado
  raise ArgumentError, "This is not valid."

  # recomendado
  raise ArgumentError, "this is not valid"
  ```

### <a name="collections"></a> Colecciones

* <a name="keyword-list-syntax"></a>
  Usar siempre la sintaxis especial para listas de keywords.
  <sup>[[enlace](#keyword-list-syntax)]</sup>

  ```elixir
  # no recomendado
  some_value = [{:a, "baz"}, {:b, "qux"}]

  # recomendado
  some_value = [a: "baz", b: "qux"]
  ```

* <a name="map-key-atom"></a>
  Usar la sintaxis abreviada de llave-valor para los mapas cuando todas las llaves son átomos.
  <sup>[[link](#map-key-atom)]</sup>

  ```elixir
  # no recomendado
  %{:a => 1, :b => 2, :c => 0}

  # recomendado
  %{a: 1, b: 2, c: 3}
  ```

* <a name="map-key-arrow"></a>
  Usar la sintaxis detallada de llave-valor para los mapas si alguna clave no es un átomo.
  <sup>[[link](#map-key-arrow)]</sup>

  ```elixir
  # no recomendado
  %{"c" => 0, a: 1, b: 2}

  # recomendado
  %{:a => 1, :b => 2, "c" => 0}
  ```

### <a name="strings"></a> Cadenas

* <a name="strings-matching-with-concatenator"></a>
  Hacer coincidencia de cadenas utilizando la concatenación de string en lugar de patrones
  binarios:
  <sup>[[enlace](#strings-matching-with-concatenator)]</sup>

  ```elixir
  # no recomendado
  <<"my"::utf8, _rest::bytes>> = "my string"

  # recomendado
  "my" <> _rest = "my string"
  ```

### <a name="regex"></a> Expresiones Regulares

_Por el momento no se han añadido recomendaciones para expresiones regulares._

### <a name="metaprogramming">Metaprogramación</a>

* <a name="avoid-metaprogramming"></a>
  Evita la metaprogramación innecesaria.
  <sup>[[enlace](#avoid-metaprogramming)]</sup>

### Testing

* <a name="testing-assert-order"></a>
  Cuando se escriban aserciones con [ExUnit], colocar la expresión que se está probando a la izquierda
  del operador, y el resultado esperado a la derecha, a menos que sea
  un patrón de coincidencia (pattern match)
  <sup>[[Enlace](#testing-assert-order)]</sup>

  ```elixir
  # recomendado
  assert actual_function(1) == true

  # no recomendado
  assert true == actual_function(1)

  # obligatorio - la aserción es un pattern match
  assert {:ok, expected} = actual_function(3)
  ```

## <a name="resources"></a> Recursos

### <a name="alternative-style-guides">Guías de Estilo Alternativas</a>

* [Aleksei Magusev's Elixir Style Guide](https://github.com/lexmag/elixir-style-guide#readme)
  — Guía que surge del estilo de programación utilizado en las librerías del
  core de Elixir.
  Desarrollada por [Aleksei Magusev](https://github.com/lexmag) y
  [Andrea Leopardi](https://github.com/whatyouhide), miembros del equipo principal
  de Elixir.
  Aunque el proyecto Elixir no se adhiere a ninguna guía de estilo específica, esta
  es la guía más cercana a sus convenciones.

* [Credo's Elixir Style Guide](https://github.com/rrrene/elixir-style-guide#readme)
  — Guía de Estilo para el lenguaje Elixir, implementada para la herramienta de análisis
  estático de código [Credo](http://credo-ci.org).

### <a name="tools"> Herramientas

Dirigirse a [Awesome Elixir][Code Analysis] para encontrar bibliotecas y herramientas
que puedan ayudar con el análisis de código y corrección estilo.

## <a name="getting-involved">Cómo participar</a>

### <a name="contributing"></a> Contribuir

Es nuestra esperanza que esto se convierta en un lugar central en el que la comunidad
discuta las mejores prácticas en Elixir.
Estás invitado a abrir tickets y a enviar pull requests con mejoras.
¡Gracias por tu ayuda por adelantado!

Revisa la [guía para contribuir][Contributing]
y el [código de conducta][Code Of Conduct] (ambos en inglés) para más información.

### Corre la voz

Una guía de estilo de la comunidad no tiene sentido sin el soporte de la comunidad.
Por favor tuitea, ponle [star][Stargazers], y haz que otros programadores de Elixir
conozcan [esta guía][Elixir Style Guide] de forma que puedan contribuir.

## Derechos

### Licencia

![Creative Commons License](http://i.creativecommons.org/l/by/3.0/88x31.png)
Este trabajo está hecho bajo licencia
[Creative Commons Attribution 3.0 Unported License][License]

### <a name="attribution">Atribución</a>

La estructura de esta guía, partes del código de ejemplo, y muchos otros puntos iniciales
de este documento fueron tomados de la [Ruby community style guide].
Muchas cosas ya eran directamente aplicables a Elixir, lo que permitió sacar
antes este documento y empezar más rápido.

Aquí está la [lista de gente que ha contribuido amablemente][Contributors] a este
proyecto.

<!-- Enlaces -->
[Chino Simplificado]: https://github.com/geekerzp/elixir_style_guide/blob/master/README-zhCN.md
[Chino Tradicional]: https://github.com/elixirtw/elixir_style_guide/blob/master/README_zhTW.md
[Code Analysis]: https://github.com/h4cc/awesome-elixir#code-analysis
[Code Of Conduct]: https://github.com/christopheradams/elixir_style_guide/blob/master/CODE_OF_CONDUCT.md
[Code Formatter]: https://hexdocs.pm/elixir/Code.html#format_string!/2
[Conflicting Aliases]: https://elixirforum.com/t/using-aliases-for-fubar-fubar-named-module/1723
[Contributing]: https://github.com/elixir-lang/elixir/blob/master/CODE_OF_CONDUCT.md
[Contributors]: https://github.com/christopheradams/elixir_style_guide/graphs/contributors
[Elixir Style Guide]: https://github.com/christopheradams/elixir_style_guide
[Elixir]: http://elixir-lang.org
[Español]: https://github.com/albertoalmagro/elixir_style_guide/blob/spanish/README_esES.md
[ExDoc]: https://github.com/elixir-lang/ex_doc
[Frances]: https://github.com/ronanboiteau/elixir_style_guide/blob/master/README_frFR.md[ExUnit]: https://hexdocs.pm/ex_unit/ExUnit.html
[Guard Expressions]: http://elixir-lang.org/getting-started/case-cond-and-if.html#expressions-in-guard-clauses
[Hex]: https://hex.pm/packages
[Ingles]: https://github.com/christopheradams/elixir_style_guide/
[Japones]: https://github.com/kenichirow/elixir_style_guide/blob/master/README-jaJP.md
[Coreano]: https://github.com/marocchino/elixir_style_guide/blob/new-korean/README-koKR.md
[License]: http://creativecommons.org/licenses/by/3.0/deed.en_US
[mix format]: https://hexdocs.pm/mix/Mix.Tasks.Format.html
[Module Attributes]: http://elixir-lang.org/getting-started/module-attributes.html#as-annotations
[Portugues]: https://github.com/gusaiani/elixir_style_guide/blob/master/README_ptBR.md
[Ruby community style guide]: https://github.com/bbatsov/ruby-style-guide
[Sentence Spacing]: http://en.wikipedia.org/wiki/Sentence_spacing
[Stargazers]: https://github.com/christopheradams/elixir_style_guide/stargazers