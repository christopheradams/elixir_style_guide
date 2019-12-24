defmodule ElixirStyleGuide.Mixfile do
  use Mix.Project

  @project_description """
  A community driven style guide for Elixir
  """

  @version "0.2.0-dev"
  @source_url "https://github.com/christopheradams/elixir_style_guide"

  def project do
    [
      app: :elixir_style_guide,
      version: @version,
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      docs: docs(),
      description: @project_description,
      source_url: @source_url,
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.20.1", runtime: false},
      {:ex_doc_makeup, "~> 0.1.0"}
    ]
  end

  defp docs() do
    [
      source_ref: "v#{@version}",
      main: "readme",
      markdown_processor: ExDocMakeup,
      extras: [
        "README.md": [title: "README"]
      ]
    ]
  end

  defp package do
    [
      name: "Elixir Style Guide",
      maintainers: ["Christopher Adams"],
      licenses: ["CC-by"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end
end
