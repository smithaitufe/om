defmodule Store.Repo.Migrations.CreateCity do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string, limit: 150, null: false
      add :state_id, references(:states), null: false

      timestamps
    end
    create index(:cities, [:state_id])

  end
end
