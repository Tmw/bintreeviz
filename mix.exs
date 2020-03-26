defmodule Bintreeviz.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :bintreeviz,
      version: @version,
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Bintreeviz renders binary tree structures to string. Out of the box it supports positioning using the WS algorithm and renders to ASCII.
    """
  end

  defp package() do
    [
      maintainers: ["Tiemen Waterreus"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tmw/bintreeviz"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      name: "Bintreeviz",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/bintreeviz",
      source_url: "https://github.com/tmw/bintreeviz",
      extras: [
        "README.md"
      ]
    ]
  end

  # Additional files to include in compile step
  defp elixirc_paths(:prod), do: ["lib"]
  defp elixirc_paths(_), do: ["lib", "test/support"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:textmatrix, "~> 0.2.0"},
      {:ex_doc, "~> 0.21.3"}
    ]
  end
end
