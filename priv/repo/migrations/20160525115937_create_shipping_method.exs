defmodule Store.Repo.Migrations.CreateShippingMethod do
  use Ecto.Migration

  def change do
    create table(:shipping_methods) do
      add :name, :string, size: 100, null: false
      add :shipping_zone_id, references(:shipping_zones)
      add :minimum_days, :integer, default: 1, null: false
      add :maximum_days, :integer, default: 1, null: false
      add :rate, :decimal, precision: 8, scale: 2, default: 0.0, null: false

      timestamps
    end
    create index(:shipping_methods, [:shipping_zone_id])

  end
end
