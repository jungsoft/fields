use Mix.Config

config :fields, Fields,
  secret_key_base: "rVOUu+QTva+VlRJJI3wSYONRoffFQH167DfiZcegvYY/PEasjPLKIDz7wPTvTPIP"

config :fields, Fields.AES,
  key: "i6uIb0FMGd8fouIDd/4qkf6LhI6PG/ZKpHBEN2ed5Mk=" |> :base64.decode

# Repos known to Ecto:
config :fields, ecto_repos: [Fields.Repo]

# Test Repo settings
config :fields, Fields.Repo,
database: "fields_test",
hostname: "localhost",
poolsize: 10,
# Ensure async testing is possible:
pool: Ecto.Adapters.SQL.Sandbox

import_config "db.secret.exs"
