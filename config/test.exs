use Mix.Config

config :fields, Fields,
  secret_key_base: "rVOUu+QTva+VlRJJI3wSYONRoffFQH167DfiZcegvYY/PEasjPLKIDz7wPTvTPIP"

config :fields, Fields.AES,
  key: "i6uIb0FMGd8fouIDd/4qkf6LhI6PG/ZKpHBEN2ed5Mk=" |> :base64.decode
