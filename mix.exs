defmodule Base58Encode.MixProject do
  use Mix.Project

  def project do
    [
      app: :base58encode,
      name: "b58",
      description: description(),
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/dwyl/base58encode"
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
    []
  end

  defp description() do
    "Encode an Elixir binary to its base58 representation"
  end
end
