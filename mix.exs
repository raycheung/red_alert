defmodule RedAlert.Mixfile do
  use Mix.Project

  def project do
    [app: :red_alert,
     version: "0.2.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     elixirc_paths: elixirc_paths(Mix.env),
     description: description(),
     package: package(),
     name: "RedAlert"]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {RedAlert, []},
     applications: [:logger, :timex]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:timex, "~> 3.0"},
     {:ex_doc, ">= 0.0.0", only: :dev},
     {:credo, "~> 0.4", only: [:dev, :test]}]
  end

  # This makes sure your factory and any other modules in test/support are compiled
  # when in the test environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp description do
    """
    Monitor events that do NOT happen in designated schedule.
    """
  end

  defp package do
    [maintainers: ["Ray Cheung"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/raycheung/red_alert"}]
  end
end
