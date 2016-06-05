defmodule Store.Repo.Migrations.CreateAddressType do
  use Ecto.Migration

  def change do
    create table(:address_types) do
      add :name, :string

      timestamps
    end

  end
end
