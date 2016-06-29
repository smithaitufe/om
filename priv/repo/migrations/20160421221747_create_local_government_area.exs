defmodule Store.Repo.Migrations.CreateLocalGovernmentArea do
  use Ecto.Migration

  def change do
    create table(:local_government_areas) do
      add :name, :string
      add :state_id, references(:states)

      timestamps
    end
    create index(:local_government_areas, [:state_id])

  end
end
