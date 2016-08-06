# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :store, Store.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "taC1lGVFHG3kONVmW2vo24qVrTQ+RyC/utlQJ6LSInlqARETmwS8KuYugcJxmlPX",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Store.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  # Configures Guardian to tailor JWT generation behaviour
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Store",
  ttl: { 3, :days },
  verify_issuer: true, # optional
  secret_key: "SRE8FGl7O6Xy-oIjdvcl4TRrx9EqKEkU_vKTi2qV3S95vfh1RB9gqiBJ6Uys-NuhSWCOn3FO84JFdpXy",
  serializer: Store.GuardianSerializer

# Configure Ecto tasks such as migrate
config :store, ecto_repos: [Store.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
