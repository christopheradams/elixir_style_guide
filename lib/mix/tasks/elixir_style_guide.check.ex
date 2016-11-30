defmodule Mix.Tasks.ElixirStyleGuide.Check do
  use Mix.Task

  @shortdoc "Checks Elixir Style Guide markdown file"

  @errors [
    [
      regex: ~r/[^\s]$(?:\n{2}|\n{4,})\#{1,3}\ /m,
      error: "H1/H2/H3 headers should be preceded by two blank lines"
    ]
  ]

  def run(args) do
    {_opts, parsed, _} = OptionParser.parse(args)

    filenames =
      case parsed do
        [] -> Mix.raise "missing file"
        filenames -> filenames
      end

    filenames
    |> check_files
    |> print_reports
  end

  defp check_files(filenames) when is_list(filenames) do
    filenames
    |> Enum.map(&check_file/1)
    |> List.flatten
  end

  defp check_file(filename) do
    {:ok, contents} = File.read(filename)

    errors = check_contents(contents)

    Enum.map(errors, fn error ->
      Map.put(error, :filename, filename)
    end)
  end

  defp check_contents(contents) do
    @errors
    |> Enum.map(&(detect_error(&1, contents)))
    |> List.flatten
  end

  defp detect_error(error, contents) do
    regex = error[:regex]

    matches =
      case Regex.scan(regex, contents, capture: :first) do
        nil -> []
        captures -> List.flatten(captures)
      end

    line_nums = identify_lines(matches, contents)

    Enum.map(line_nums, fn num ->
      %{line: num, error: error[:error]}
    end)
  end

  defp identify_lines(matches, contents) do
    {line_nums, _} =
      Enum.map_reduce(matches, {0, contents}, fn(match, {line, text}) ->
        [head | rest] = String.split(text, match, parts: 2)
        content = head <> match
        newlines = Regex.scan(~r/\n/, content)
        num = length(newlines)
        [next] = rest
        {line + num + 1, {line + num, next}}
    end)
    line_nums
  end

  defp print_reports(reports) do
    Enum.each(reports, fn report ->
      error = "#{report.filename}:#{report.line}: #{report.error}"
      Mix.shell.error(error)
    end)
  end
end
