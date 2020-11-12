defmodule Base58.MixProject do
  use Mix.Project

  def project do
    [
      app: :B58,
      name: "b58",
      description: description(),
      package: package(),
      version: "1.0.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.json": :test
      ],
      source_url: "https://github.com/dwyl/base58"
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
      {:excoveralls, "~> 0.12.3", only: :test},
      {:basefiftyeight, "~> 0.1.0", only: :test},
      {:stream_data, "~> 0.5", only: :test},
      {:ex_doc, "~> 0.23", only: :dev}
    ]
  end

  defp description() do
    "B58 lets you encode an Elixir binary to base58 and decode a base58 string."
  end

  defp package() do
    [
      name: "b58",
      licenses: ["GNU GPL v2.0"],
      maintainers: ["dwyl"],
      links: %{"GitHub" => "https://github.com/dwyl/base58"}
    ]
  end
end
