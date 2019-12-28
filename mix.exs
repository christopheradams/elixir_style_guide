defmodule ElixirStyleGuide.Mixfile do
  use Mix.Project

  @project_description """
  A community driven style guide for Elixir
  """

  @version "0.2.0"
  @source_url "https://github.com/christopheradams/elixir_style_guide"

  def project do
    [
      name: "Elixir Style Guide",
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
      main: "README",
      markdown_processor: ExDocMakeup,
      extras: extras(),
      groups_for_extras: groups_for_extras()
    ]
  end

  defp extras do
    [
      "README.md": [title: "README"],
      "CONTRIBUTING.md": [title: "CONTRIBUTING"],
      "TRANSLATIONS.md": [title: "TRANSLATIONS"],
      "i18n/README_es.md": [title: "Spanish"]
    ]
  end

  defp groups_for_extras do
    [
      Translations: ~r/i18n\/[^\/]+\.md/
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
