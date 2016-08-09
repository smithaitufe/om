use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :store, Store.Endpoint,
  secret_key_base: "xGLRgSfiXwNspmFRrFhsyaf0IW3S7Sll0+pNtkis6jepXwEhriqGVcUyL0Fq6ryS"

# Configure your database
config :store, Store.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "store_prod",
  pool_size: 20
