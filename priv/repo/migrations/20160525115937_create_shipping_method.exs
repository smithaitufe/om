defmodule Store.Repo.Migrations.CreateShippingMethod do
  use Ecto.Migration

  def change do
    create table(:shipping_methods) do
      add :name, :string, size: 100, null: false
      add :shipping_zone_id, references(:shipping_zones)

      timestamps
    end
    create index(:shipping_methods, [:shipping_zone_id])

  end
end
