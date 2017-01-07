defmodule Store.Mixfile do
  use Mix.Project

  def project do
    [
     app: :store,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     aliases: aliases
   ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Store, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :phoenix_ecto, :postgrex]
   ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
     {:phoenix, "~> 1.0.0"},
     {:ecto, "~> 2.0", override: true},
     {:phoenix_ecto, "~> 3.0.0-rc"},
     {:postgrex, ">= 0.11.2"},
     {:phoenix_html, "~> 2.1"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"},
     {:corsica, "~> 0.4"},
     {:comeonin, "~> 2.1"},
     {:guardian, "~> 0.10.0"},
     {:timex, "~> 2.1.4"},
     {:timex_ecto, "~> 1.0.4"},
     {:arc, "~> 0.6.0"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
