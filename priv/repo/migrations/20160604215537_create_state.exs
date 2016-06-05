defmodule Store.Repo.Migrations.CreateState do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :name, :string, limit: 150, null: false, unique: true
      add :described_as, :string
      add :abbreviation, :string, limit: 5, null: false, unique: true
      add :country_id, references(:countries), null: false
      add :shipping_zone_id, references(:shipping_zones), null: false

      timestamps
    end
    create index(:states, [:country_id])
    create index(:states, [:shipping_zone_id])
    create index(:states, [:name])
    create index(:states, [:abbreviation])

  end
end
