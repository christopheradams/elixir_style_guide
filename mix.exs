defmodule ElixirStyleGuide.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_style_guide,
     version: "0.1.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev},
     {:credo, "~> 0.5", only: [:dev, :test]}]
  end
end
