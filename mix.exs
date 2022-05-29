defmodule Fields.MixProject do
  use Mix.Project

  def project do
    [
      app: :fields,
      version: "0.2.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def elixirc_paths(:test), do: ["lib", "test/support"]
  def elixirc_paths(_), do: ["lib"]


  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:argon2_elixir, "~> 3.0"},
      {:ecto, ">= 3.0.0"},
      {:stream_data, "~> 0.5.0", only: :test},
    ]
  end
end
