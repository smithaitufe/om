defmodule Store.Repo.Migrations.CreateCity do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string, limit: 150, null: false
      add :state_id, references(:states), null: false
      add :shipping_zone_id, references(:shipping_zones), null: false

      timestamps
    end
    create index(:cities, [:state_id])
    create index(:cities, [:shipping_zone_id])

  end
end
