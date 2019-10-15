defmodule Fields.MixProject do
  use Mix.Project

  def project do
    [
      app: :fields,
      version: "0.1.7",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:argon2_elixir, "~> 1.2"},
      {:ecto, ">= 3.0.0"},
      {:stream_data, "~> 0.4.2", only: :test},
    ]
  end
end
