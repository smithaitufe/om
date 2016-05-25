defmodule Store.Repo.Migrations.CreatePrototypeProperty do
  use Ecto.Migration

  def change do
    create table(:prototype_properties) do
      add :prototype_id, references(:prototypes)
      add :property_id, references(:properties)

      timestamps
    end
    create index(:prototype_properties, [:prototype_id])
    create index(:prototype_properties, [:property_id])

  end
end
