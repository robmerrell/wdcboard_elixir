defmodule Wdcboard.Mixfile do
  use Mix.Project

  def project do
    [ app: :wdcboard,
      version: "0.0.1",
      build_per_environment: true,
      dynamos: [Wdcboard.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [
        dev: [deps: deps],
        test: [deps: deps ++ test_deps],
        prod: [deps: deps]
      ]]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo, :httpotion],
      mod: { Wdcboard, [] } ]
  end

  defp deps do
    [ {:cowboy, github: "extend/cowboy"},
      {:dynamo, "~> 0.1.0-dev", github: "elixir-lang/dynamo"},
      {:httpotion, "0.2.3", [github: "myfreeweb/httpotion"]},
      {:json, "0.2.7",  github: "cblage/elixir-json"}]
  end

  defp test_deps do
    [ {:mock, "0.0.3", github: "jjh42/mock"} ] 
  end
end
