
defmodule Crudry.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :url, :string
      add :phone_number, :string
      add :address, :string
      add :postcode, :string

      timestamps()
    end
  end
end
