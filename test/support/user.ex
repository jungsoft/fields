defmodule Fields.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :url, :string
    field :phone_number, :string
    field :postcode, :string
    timestamps()
  end


  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:email, :url, :phone_number, :postcode])
  end
end
