defmodule Store.Repo.Migrations.CreateCountry do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string, limit: 100, null: false
      add :abbreviation, :string, limit: 5
      add :active, :boolean, default: false
      add :shipping_zone_id, references(:shipping_zones)

      timestamps
    end
    create index(:countries, [:shipping_zone_id])
    create index(:countries, [:name])
    create index(:countries, [:active])

  end
end
