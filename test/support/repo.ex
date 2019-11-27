defmodule Fields.Repo do
  use Ecto.Repo,
    otp_app: :fields,
    adapter: Ecto.Adapters.Postgres
end
