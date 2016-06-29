defmodule Store.Repo.Migrations.CreateShippingZone do
  use Ecto.Migration

  def change do
    create table(:shipping_zones) do
      add :name, :string, size: 100, null: false

      timestamps
    end

  end
end
